import { apiClient } from './client';
import {
  AdminRole,
  AdminUserDetail,
  AdminUserListItem,
} from '@/types/admin-auth.types';

export function getAdminUsers() {
  return apiClient.get<AdminUserListItem[]>('/admin/users', undefined, 'auth');
}

export function getAdminUser(id: string) {
  return apiClient.get<AdminUserDetail>(`/admin/users/${id}`, undefined, 'auth');
}

export function updateAdminUserStatus(id: string, status: string) {
  return apiClient.patch<AdminUserListItem>(
    `/admin/users/${id}/status`,
    { status },
    'auth',
  );
}

export function updateAdminUserRoles(id: string, roles: AdminRole[]) {
  return apiClient.patch<AdminUserDetail>(
    `/admin/users/${id}/roles`,
    { roles },
    'auth',
  );
}