'use client';

import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import { Loader2, ShieldAlert } from 'lucide-react';
import { getAdminContext, getStoredAdminToken } from '@/lib/api/admin-auth';

export default function AdminAuthGuard({
  children,
}: {
  children: React.ReactNode;
}) {
  const router = useRouter();
  const [checking, setChecking] = useState(true);
  const [blocked, setBlocked] = useState(false);

  useEffect(() => {
    let alive = true;

    async function run() {
      try {
        const token = getStoredAdminToken();

        if (!token) {
          router.replace('/sign-in');
          return;
        }

        const ctx = await getAdminContext();

        const allowed =
          ctx.roles.includes('admin') ||
          ctx.roles.includes('moderator') ||
          ctx.roles.includes('auditor');

        if (!allowed) {
          if (alive) setBlocked(true);
          return;
        }
      } catch {
        router.replace('/sign-in');
      } finally {
        if (alive) setChecking(false);
      }
    }

    run();

    return () => {
      alive = false;
    };
  }, [router]);

  if (checking) {
    return (
      <div className="grid min-h-screen place-items-center bg-[var(--bb-bg)]">
        <div className="bb-glass rounded-3xl px-8 py-7 text-center shadow-2xl">
          <Loader2 className="mx-auto h-8 w-8 animate-spin text-[var(--bb-purple)]" />
          <p className="mt-4 text-sm font-bold text-[var(--bb-muted)]">
            Checking admin session...
          </p>
        </div>
      </div>
    );
  }

  if (blocked) {
    return (
      <div className="grid min-h-screen place-items-center bg-[var(--bb-bg)] p-6">
        <div className="bb-glass max-w-md rounded-3xl p-8 text-center shadow-2xl">
          <ShieldAlert className="mx-auto h-12 w-12 text-[var(--bb-red)]" />
          <h1 className="mt-4 text-2xl font-black">Access denied</h1>
          <p className="mt-2 text-sm text-[var(--bb-muted)]">
            This account does not have admin dashboard access.
          </p>
        </div>
      </div>
    );
  }

  return <>{children}</>;
}