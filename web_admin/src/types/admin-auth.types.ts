export type AdminRole = 'learner' | 'admin' | 'moderator' | 'auditor';

export type AuthContext = {
  user_id: string;
  email: string | null;
  email_confirmed_at: string | null;
  last_sign_in_at: string | null;
  roles: AdminRole[];
  is_admin: boolean;
  is_moderator: boolean;
  is_auditor: boolean;
  profile: AuthProfile | null;
  learner_profile: AuthLearnerProfile | null;
  settings: AuthSettings | null;
  wallets: AuthWallet[];
  needs_profile_setup: boolean;
  needs_onboarding: boolean;
};

export type AuthProfile = {
  id: string;
  email: string | null;
  username: string | null;
  display_name: string | null;
  avatar_url: string | null;
  bio: string | null;
  status: string;
  created_at?: string;
  updated_at?: string;
};

export type AuthLearnerProfile = {
  user_id: string;
  goal_type: string | null;
  current_level: string | null;
  target_level: string | null;
  native_language: string | null;
  target_language: string | null;
  focus_skills: string[];
  weak_skills: string[];
  onboarding_completed: boolean;
};

export type AuthSettings = {
  timezone: string | null;
  language: string | null;
  notification_enabled: boolean;
};

export type AuthWallet = {
  id: string;
  wallet_address: string;
  chain: string;
  is_primary: boolean;
  verified_at: string | null;
  created_at: string;
};

export type AdminUserListItem = {
  user_id: string;
  email: string | null;
  username: string | null;
  display_name: string | null;
  avatar_url: string | null;
  bio: string | null;
  status: string;
  roles: AdminRole[];
  learner_profile: AuthLearnerProfile | null;
  settings: AuthSettings | null;
  wallet_count: number;
  created_at: string;
  updated_at: string;
};

export type AdminUserDetail = AdminUserListItem & {
  wallets: AuthWallet[];
  audit_events: Array<{
    id?: string;
    eventType?: string;
    event_type?: string;
    payload: unknown;
    createdAt?: string;
    created_at?: string;
  }>;
};