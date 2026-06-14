'use client';

import { useEffect, useState } from 'react';
import { usePathname, useRouter } from 'next/navigation';
import { LogOut, Moon, Sun } from 'lucide-react';
import { signOutAdmin } from '@/lib/api/admin-auth';

const pageInfo: Record<string, { title: string; description: string }> = {
  '/admin': { title: 'Production Overview', description: 'Battle ecosystem, auth readiness and blockchain traceability.' },
  '/admin/users/learners': { title: 'Learner Accounts', description: 'Manage auth, profile, roles, account status and wallet readiness.' },
  '/admin/questions': { title: 'Question Bank', description: 'Create, review and approve battle questions with media URL support.' },
  '/admin/rooms': { title: 'Rooms', description: 'Monitor lobby state, team slots, roles and ready checks.' },
  '/admin/battles': { title: 'Battle Operations', description: 'Inspect realtime match result, scoreboard and settlement.' },
  '/admin/ranking': { title: 'Ranking', description: 'Inspect rank profile and star change logs.' },
  '/admin/rewards': { title: 'Reward Ledger', description: 'Inspect BrainPoint wallet and ledger.' },
  '/admin/shop': { title: 'Shop & Inventory', description: 'Inspect BrainPoint items and player inventory.' },
  '/admin/evidence': { title: 'Blockchain Evidence', description: 'Verify resultHash, txHash and on-chain record.' },
  '/admin/audit-logs': { title: 'Audit Logs', description: 'Central trace points across backend operations.' },
  '/admin/settings': { title: 'System Settings', description: 'Frontend runtime configuration.' },
};

function getPageInfo(pathname: string) {
  if (pathname.startsWith('/admin/users/learners/')) return { title: 'Learner Detail', description: 'Inspect profile, roles, wallet links and account events.' };
  return pageInfo[pathname] ?? pageInfo['/admin'];
}

export default function Header() {
  const pathname = usePathname();
  const router = useRouter();
  const current = getPageInfo(pathname);
  const [dark, setDark] = useState(true);

  useEffect(() => {
    const stored = typeof window !== 'undefined' ? localStorage.getItem('brainbattle_admin_theme') : null;
    if (stored === 'light') setDark(false);
  }, []);

  useEffect(() => {
    document.documentElement.classList.toggle('dark', dark);
    localStorage.setItem('brainbattle_admin_theme', dark ? 'dark' : 'light');
  }, [dark]);

  async function logout() {
    await signOutAdmin();
    router.replace('/sign-in');
  }

  return (
    <header className="sticky top-0 z-40 border-b border-[var(--bb-border)] bg-[var(--bb-bg)]/78 px-5 py-4 backdrop-blur-xl md:px-8">
      <div className="mx-auto flex max-w-[1440px] items-center justify-between gap-4">
        <div className="min-w-0">
          <h1 className="bb-gradient-text truncate text-xl font-black tracking-tight md:text-2xl">{current.title}</h1>
          <p className="mt-1 truncate text-xs font-semibold text-[var(--bb-muted)] md:text-sm">{current.description}</p>
        </div>
        <div className="flex items-center gap-2">
          <button type="button" onClick={() => setDark((v) => !v)} className="rounded-full border border-[var(--bb-border)] bg-[var(--bb-surface)] p-2 text-[var(--bb-text)] shadow-sm">{dark ? <Sun className="h-4 w-4" /> : <Moon className="h-4 w-4" />}</button>
          <button type="button" onClick={logout} className="inline-flex items-center gap-2 rounded-full border border-[var(--bb-border)] bg-[var(--bb-surface)] px-4 py-2 text-sm font-bold text-[var(--bb-text)] shadow-sm"><LogOut className="h-4 w-4" />Logout</button>
        </div>
      </div>
    </header>
  );
}
