import axios, { AxiosError, AxiosInstance } from 'axios';
import { AUTH_API_BASE_URL, BATTLE_API_BASE_URL } from './config';

type ApiTarget = 'auth' | 'battle';

export class BrainBattleApiError extends Error {
  status?: number;
  data?: unknown;

  constructor(message: string, status?: number, data?: unknown) {
    super(message);
    this.name = 'BrainBattleApiError';
    this.status = status;
    this.data = data;
  }
}

function cleanParams(params?: Record<string, unknown>) {
  if (!params) return undefined;

  return Object.fromEntries(
    Object.entries(params).filter(([, value]) => {
      if (value === undefined || value === null) return false;
      if (value === '') return false;
      if (value === 'All') return false;
      return true;
    }),
  );
}

function normalizeResponse<T>(payload: any): T {
  if (payload && typeof payload === 'object' && 'data' in payload) {
    return payload.data as T;
  }
  return payload as T;
}

function buildError(error: AxiosError) {
  const status = error.response?.status;
  const data: any = error.response?.data;
  const message =
    data?.message instanceof Array
      ? data.message.join(', ')
      : data?.message || data?.error || error.message || 'Request failed';

  return new BrainBattleApiError(message, status, data);
}

class ApiClient {
  private authClient: AxiosInstance;
  private battleClient: AxiosInstance;

  constructor() {
    this.authClient = this.createClient(AUTH_API_BASE_URL);
    this.battleClient = this.createClient(BATTLE_API_BASE_URL);
  }

  private createClient(baseURL: string): AxiosInstance {
    const client = axios.create({
      baseURL,
      headers: {
        'Content-Type': 'application/json',
      },
      timeout: 30000,
      withCredentials: false,
    });

    client.interceptors.request.use((config) => {
      if (typeof window !== 'undefined') {
        const token = localStorage.getItem('brainbattle_admin_access_token');

        if (token) {
          config.headers.Authorization = `Bearer ${token}`;
        }
      }

      return config;
    });

    client.interceptors.response.use(
      (response) => response,
      (error: AxiosError) => Promise.reject(buildError(error)),
    );

    return client;
  }

  private getClient(target: ApiTarget): AxiosInstance {
    return target === 'auth' ? this.authClient : this.battleClient;
  }

  async get<T = unknown>(
    url: string,
    params?: Record<string, unknown>,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).get(url, {
      params: cleanParams(params),
    });
    return normalizeResponse<T>(response.data);
  }

  async post<T = unknown>(
    url: string,
    data?: unknown,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).post(url, data);
    return normalizeResponse<T>(response.data);
  }

  async put<T = unknown>(
    url: string,
    data?: unknown,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).put(url, data);
    return normalizeResponse<T>(response.data);
  }

  async patch<T = unknown>(
    url: string,
    data?: unknown,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).patch(url, data);
    return normalizeResponse<T>(response.data);
  }

  async delete<T = unknown>(url: string, target: ApiTarget = 'battle'): Promise<T> {
    const response = await this.getClient(target).delete(url);
    return normalizeResponse<T>(response.data);
  }
}

export const apiClient = new ApiClient();
