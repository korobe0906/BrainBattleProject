'use client';

import { useEffect, useState } from 'react';
import { useParams } from 'next/navigation';
import { UserRound } from 'lucide-react';
import {
  getAdminUser,
  updateAdminUserRoles,
  updateAdminUserStatus,
} from '@/lib/api/admin-users';
import { AdminRole, AdminUserDetail } from '@/types/admin-auth.types';

const statuses = ['active', 'blocked', 'disabled', 'pending'];
const roles: AdminRole[] = ['learner', 'admin', 'moderator', 'auditor'];

export default function LearnerDetailPage() {
  const params = useParams<{ id: string }>();
  const [user, setUser] = useState<AdminUserDetail | null>(null);
  const [saving, setSaving] = useState(false);

  async function reload() {
    setUser(await getAdminUser(params.id));
  }

  useEffect(() => {
    reload();
  }, [params.id]);

  async function setStatus(status: string) {
    setSaving(true);
    try {
      await updateAdminUserStatus(params.id, status);
      await reload();
    } finally {
      setSaving(false);
    }
  }

  async function toggleRole(role: AdminRole) {
    if (!user) return;

    const next = user.roles.includes(role)
      ? user.roles.filter((item) => item !== role)
      : [...user.roles, role];

    if (!next.length) return;

    setSaving(true);
    try {
      await updateAdminUserRoles(params.id, next);
      await reload();
    } finally {
      setSaving(false);
    }
  }

  if (!user) {
    return <p className="text-sm font-bold text-[var(--bb-muted)]">Loading...</p>;
  }

  return (
    <div className="space-y-6 pb-10">
      <section className="bb-glass rounded-[32px] p-6 shadow-xl md:p-8">
        <div className="flex gap-4">
          <div className="grid h-14 w-14 place-items-center rounded-2xl bg-gradient-to-br from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] text-white shadow-lg">
            <UserRound className="h-7 w-7" />
          </div>

          <div>
            <p className="text-xs font-black uppercase tracking-[0.25em] text-[var(--bb-muted)]">
              Learner Detail
            </p>
            <h1 className="mt-1 text-2xl font-black tracking-tight md:text-3xl">
              {user.display_name || user.username || user.email || 'User'}
            </h1>
            <p className="mt-2 max-w-3xl text-sm leading-6 text-[var(--bb-muted)]">
              View profile, learner setup, roles, wallet links and audit events.
            </p>
          </div>
        </div>
      </section>

      <div className="grid gap-6 xl:grid-cols-[1fr_0.85fr]">
        <section className="bb-glass rounded-[28px] p-5 shadow-xl">
          <h2 className="text-lg font-black">Profile</h2>

          <div className="mt-5 grid gap-4 md:grid-cols-2">
            <Info label="Email" value={user.email ?? '-'} />
            <Info label="Username" value={user.username ?? '-'} />
            <Info label="Display name" value={user.display_name ?? '-'} />
            <Info label="Status" value={user.status} />
            <Info
              label="Target language"
              value={user.learner_profile?.target_language ?? '-'}
            />
            <Info
              label="Goal"
              value={user.learner_profile?.goal_type ?? '-'}
            />
            <Info
              label="Current level"
              value={user.learner_profile?.current_level ?? '-'}
            />
            <Info
              label="Onboarding"
              value={
                user.learner_profile?.onboarding_completed
                  ? 'Completed'
                  : 'Not completed'
              }
            />
          </div>
        </section>

        <section className="bb-glass rounded-[28px] p-5 shadow-xl">
          <h2 className="text-lg font-black">Account Control</h2>

          <div className="mt-5">
            <p className="text-xs font-black uppercase tracking-wide text-[var(--bb-muted)]">
              Status
            </p>
            <div className="mt-3 flex flex-wrap gap-2">
              {statuses.map((status) => (
                <button
                  key={status}
                  disabled={saving}
                  onClick={() => setStatus(status)}
                  className="rounded-full border border-[var(--bb-border)] px-4 py-2 text-sm font-black disabled:opacity-50"
                >
                  {status}
                </button>
              ))}
            </div>
          </div>

          <div className="mt-6">
            <p className="text-xs font-black uppercase tracking-wide text-[var(--bb-muted)]">
              Roles
            </p>
            <div className="mt-3 flex flex-wrap gap-2">
              {roles.map((role) => (
                <button
                  key={role}
                  disabled={saving}
                  onClick={() => toggleRole(role)}
                  className={
                    user.roles.includes(role)
                      ? 'rounded-full bg-gradient-to-r from-[var(--bb-pink)] to-[var(--bb-purple)] px-4 py-2 text-sm font-black text-white disabled:opacity-50'
                      : 'rounded-full border border-[var(--bb-border)] px-4 py-2 text-sm font-black disabled:opacity-50'
                  }
                >
                  {role}
                </button>
              ))}
            </div>
          </div>
        </section>
      </div>

      <section className="bb-glass rounded-[28px] p-5 shadow-xl">
        <h2 className="text-lg font-black">Wallets</h2>
        <div className="mt-4 space-y-3">
          {user.wallets.length === 0 ? (
            <p className="text-sm text-[var(--bb-muted)]">No wallet linked.</p>
          ) : (
            user.wallets.map((wallet) => (
              <div
                key={wallet.id}
                className="rounded-2xl border border-[var(--bb-border)] p-4"
              >
                <p className="font-black">{wallet.chain}</p>
                <p className="break-all text-xs text-[var(--bb-muted)]">
                  {wallet.wallet_address}
                </p>
              </div>
            ))
          )}
        </div>
      </section>

      <section className="bb-glass rounded-[28px] p-5 shadow-xl">
        <h2 className="text-lg font-black">Audit Events</h2>
        <div className="mt-4 space-y-3">
          {user.audit_events?.length ? (
            user.audit_events.map((event, index) => (
              <div
                key={event.id ?? index}
                className="rounded-2xl border border-[var(--bb-border)] p-4"
              >
                <p className="font-black">
                  {event.eventType ?? event.event_type ?? 'audit.event'}
                </p>
                <pre className="mt-2 overflow-auto text-xs text-[var(--bb-muted)]">
                  {JSON.stringify(event.payload, null, 2)}
                </pre>
              </div>
            ))
          ) : (
            <p className="text-sm text-[var(--bb-muted)]">No audit events.</p>
          )}
        </div>
      </section>
    </div>
  );
}

function Info({ label, value }: { label: string; value: string }) {
  return (
    <div className="rounded-2xl border border-[var(--bb-border)] bg-white/5 p-4">
      <p className="text-xs font-black uppercase tracking-wide text-[var(--bb-muted)]">
        {label}
      </p>
      <p className="mt-1 break-words text-sm font-black">{value}</p>
    </div>
  );
}