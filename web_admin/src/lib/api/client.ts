import axios, { AxiosError, AxiosInstance } from 'axios';
import { AUTH_API_BASE_URL, BATTLE_API_BASE_URL } from './config';

type ApiTarget = 'auth' | 'battle';

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
      (error: AxiosError) => {
        if (process.env.NODE_ENV === 'development') {
          console.error('[BrainBattle API Error]', {
            baseURL,
            url: error.config?.url,
            method: error.config?.method,
            status: error.response?.status,
            data: error.response?.data,
          });
        }

        return Promise.reject(error);
      },
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
    const response = await this.getClient(target).get(url, { params });
    return response.data?.data ?? response.data;
  }

  async post<T = unknown>(
    url: string,
    data?: unknown,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).post(url, data);
    return response.data?.data ?? response.data;
  }

  async put<T = unknown>(
    url: string,
    data?: unknown,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).put(url, data);
    return response.data?.data ?? response.data;
  }

  async patch<T = unknown>(
    url: string,
    data?: unknown,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).patch(url, data);
    return response.data?.data ?? response.data;
  }

  async delete<T = unknown>(
    url: string,
    target: ApiTarget = 'battle',
  ): Promise<T> {
    const response = await this.getClient(target).delete(url);
    return response.data?.data ?? response.data;
  }
}

export const apiClient = new ApiClient();