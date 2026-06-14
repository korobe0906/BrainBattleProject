import { apiClient } from './client';
import { supabase } from '@/lib/supabase/client';
import { AuthContext } from '@/types/admin-auth.types';

const TOKEN_KEY = 'brainbattle_admin_access_token';

export function getStoredAdminToken() {
  if (typeof window === 'undefined') return null;
  return localStorage.getItem(TOKEN_KEY);
}

export function clearAdminAuth() {
  if (typeof window === 'undefined') return;
  localStorage.removeItem(TOKEN_KEY);
}

export async function signInAdmin(email: string, password: string) {
  const result = await supabase.auth.signInWithPassword({ email, password });

  if (result.error) {
    throw new Error(result.error.message);
  }

  const token = result.data.session?.access_token;

  if (!token) {
    throw new Error('Supabase access token not found');
  }

  localStorage.setItem(TOKEN_KEY, token);

  const context = await apiClient.post<AuthContext>(
    '/auth/bootstrap',
    undefined,
    'auth',
  );

  const allowed =
    context.roles.includes('admin') ||
    context.roles.includes('moderator') ||
    context.roles.includes('auditor');

  if (!allowed) {
    clearAdminAuth();
    await supabase.auth.signOut();
    throw new Error('This account does not have admin dashboard access');
  }

  return context;
}

export async function getAdminContext() {
  return apiClient.get<AuthContext>('/auth/me', undefined, 'auth');
}

export async function signOutAdmin() {
  clearAdminAuth();
  await supabase.auth.signOut();
}