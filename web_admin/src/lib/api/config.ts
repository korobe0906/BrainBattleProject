export const AUTH_API_BASE_URL =
  process.env.NEXT_PUBLIC_AUTH_API_URL || 'http://localhost:3000';

export const BATTLE_API_BASE_URL =
  process.env.NEXT_PUBLIC_BATTLE_API_URL || 'http://localhost:3001/api';

export const BATTLE_SOCKET_URL =
  process.env.NEXT_PUBLIC_BATTLE_SOCKET_URL || 'http://localhost:3001';

export const APP_ENV =
  process.env.NEXT_PUBLIC_APP_ENV || 'development';

export const IS_PRODUCTION = APP_ENV === 'production';