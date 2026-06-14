'use client';

import Link from 'next/link';
import { useEffect, useMemo, useState } from 'react';
import { Search, Users } from 'lucide-react';
import { getAdminUsers, updateAdminUserStatus } from '@/lib/api/admin-users';
import { AdminUserListItem } from '@/types/admin-auth.types';

export default function LearnersPage() {
  const [users, setUsers] = useState<AdminUserListItem[]>([]);
  const [q, setQ] = useState('');
  const [status, setStatus] = useState('All');
  const [loading, setLoading] = useState(true);

  async function reload() {
    setLoading(true);
    try {
      setUsers(await getAdminUsers());
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    reload();
  }, []);

  const filtered = useMemo(() => {
    const text = q.trim().toLowerCase();

    return users.filter((user) => {
      const okStatus = status === 'All' || user.status === status;
      const okQ =
        !text ||
        [
          user.email,
          user.username,
          user.display_name,
          user.status,
          ...user.roles,
        ]
          .filter(Boolean)
          .some((item) => item!.toLowerCase().includes(text));

      return okStatus && okQ;
    });
  }, [users, q, status]);

  async function toggleStatus(user: AdminUserListItem) {
    await updateAdminUserStatus(
      user.user_id,
      user.status === 'active' ? 'blocked' : 'active',
    );
    await reload();
  }

  return (
    <div className="space-y-6 pb-10">
      <section className="bb-glass rounded-[32px] p-6 shadow-xl md:p-8">
        <div className="flex flex-col gap-5 md:flex-row md:items-center md:justify-between">
          <div className="flex gap-4">
            <div className="grid h-14 w-14 place-items-center rounded-2xl bg-gradient-to-br from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] text-white shadow-lg">
              <Users className="h-7 w-7" />
            </div>

            <div>
              <p className="text-xs font-black uppercase tracking-[0.25em] text-[var(--bb-muted)]">
                Auth / Profile / Account
              </p>
              <h1 className="mt-1 text-2xl font-black tracking-tight md:text-3xl">
                Learner Accounts
              </h1>
              <p className="mt-2 max-w-3xl text-sm leading-6 text-[var(--bb-muted)]">
                Manage real Supabase users, app profiles, roles, account status,
                learner onboarding and wallet readiness.
              </p>
            </div>
          </div>

          <span className="rounded-full border border-[var(--bb-border)] bg-[var(--bb-surface)] px-4 py-2 text-sm font-black">
            {loading ? 'Loading...' : `${filtered.length} users`}
          </span>
        </div>
      </section>

      <section className="bb-glass rounded-[28px] p-5 shadow-xl">
        <div className="flex flex-col gap-4 md:flex-row md:items-center md:justify-between">
          <div>
            <h2 className="text-lg font-black">Users</h2>
            <p className="text-sm text-[var(--bb-muted)]">
              Showing {filtered.length} of {users.length} accounts.
            </p>
          </div>

          <div className="flex flex-col gap-3 md:flex-row">
            <div className="flex items-center gap-3 rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-strong)] px-4 py-3 md:w-[360px]">
              <Search className="h-5 w-5 text-[var(--bb-purple)]" />
              <input
                value={q}
                onChange={(e) => setQ(e.target.value)}
                placeholder="Search email, username, role..."
                className="w-full bg-transparent text-sm font-semibold outline-none"
              />
            </div>

            <select
              value={status}
              onChange={(e) => setStatus(e.target.value)}
              className="rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-strong)] px-4 py-3 text-sm font-bold outline-none"
            >
              <option>All</option>
              <option>active</option>
              <option>blocked</option>
              <option>disabled</option>
              <option>pending</option>
            </select>
          </div>
        </div>

        <div className="mt-5 overflow-x-auto rounded-2xl border border-[var(--bb-border)]">
          <table className="w-full min-w-[980px] text-left text-sm">
            <thead className="bg-white/5 text-xs uppercase text-[var(--bb-muted)]">
              <tr>
                <th className="px-4 py-3">User</th>
                <th className="px-4 py-3">Roles</th>
                <th className="px-4 py-3">Learning</th>
                <th className="px-4 py-3">Wallets</th>
                <th className="px-4 py-3">Status</th>
                <th className="px-4 py-3">Created</th>
                <th className="px-4 py-3 text-right">Actions</th>
              </tr>
            </thead>

            <tbody>
              {filtered.map((user) => (
                <tr
                  key={user.user_id}
                  className="border-t border-[var(--bb-border)]"
                >
                  <td className="px-4 py-3">
                    <p className="font-black">
                      {user.display_name || user.username || 'Unnamed user'}
                    </p>
                    <p className="text-xs text-[var(--bb-muted)]">
                      {user.email}
                    </p>
                    <p className="mt-1 max-w-[260px] truncate text-xs text-[var(--bb-muted)]">
                      {user.user_id}
                    </p>
                  </td>

                  <td className="px-4 py-3">
                    <div className="flex flex-wrap gap-1.5">
                      {user.roles.map((role) => (
                        <span
                          key={role}
                          className="rounded-full border border-[var(--bb-border)] px-2.5 py-1 text-xs font-black"
                        >
                          {role}
                        </span>
                      ))}
                    </div>
                  </td>

                  <td className="px-4 py-3">
                    {user.learner_profile?.onboarding_completed
                      ? 'Completed'
                      : 'Not completed'}
                  </td>

                  <td className="px-4 py-3">{user.wallet_count}</td>

                  <td className="px-4 py-3">
                    <StatusPill value={user.status} />
                  </td>

                  <td className="px-4 py-3 text-[var(--bb-muted)]">
                    {formatDate(user.created_at)}
                  </td>

                  <td className="px-4 py-3">
                    <div className="flex justify-end gap-2">
                      <Link
                        href={`/admin/users/learners/${user.user_id}`}
                        className="rounded-full border border-[var(--bb-border)] px-3 py-1.5 text-xs font-black"
                      >
                        Detail
                      </Link>

                      <button
                        type="button"
                        onClick={() => toggleStatus(user)}
                        className="rounded-full bg-gradient-to-r from-[var(--bb-pink)] to-[var(--bb-purple)] px-3 py-1.5 text-xs font-black text-white"
                      >
                        {user.status === 'active' ? 'Block' : 'Activate'}
                      </button>
                    </div>
                  </td>
                </tr>
              ))}

              {!filtered.length && (
                <tr>
                  <td
                    colSpan={7}
                    className="px-5 py-12 text-center text-[var(--bb-muted)]"
                  >
                    No users found.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>
    </div>
  );
}

function StatusPill({ value }: { value: string }) {
  const tone =
    value === 'active'
      ? 'border-emerald-400/40 bg-emerald-500/15 text-emerald-300'
      : value === 'blocked'
        ? 'border-red-400/40 bg-red-500/15 text-red-300'
        : 'border-yellow-400/40 bg-yellow-500/15 text-yellow-300';

  return (
    <span
      className={`inline-flex rounded-full border px-2.5 py-1 text-xs font-black uppercase tracking-wide ${tone}`}
    >
      {value}
    </span>
  );
}

function formatDate(value?: string) {
  if (!value) return '-';
  return new Date(value).toLocaleString('vi-VN', {
    hour12: false,
    day: '2-digit',
    month: '2-digit',
    year: 'numeric',
  });
}