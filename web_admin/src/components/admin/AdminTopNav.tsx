'use client';

import Image from 'next/image';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { useEffect, useRef, useState } from 'react';
import {
  ChevronDown,
  Coins,
  FileQuestion,
  Home,
  LogOut,
  Moon,
  Settings,
  ShieldCheck,
  ShoppingBag,
  Sun,
  Swords,
  Trophy,
  Users,
  WalletCards,
  DoorOpen,
  ScrollText,
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { signOutAdmin } from '@/lib/api/admin-auth';

type NavChild = {
  label: string;
  description: string;
  href: string;
  icon: React.ElementType;
};

type NavGroup = {
  label: string;
  href?: string;
  icon: React.ElementType;
  items?: NavChild[];
};

const navGroups: NavGroup[] = [
  { label: 'Home', href: '/admin', icon: Home },
  {
    label: 'Content',
    icon: FileQuestion,
    items: [
      {
        label: 'Question Bank',
        description: 'Manage battle questions, options, media URLs, validation, review and approval.',
        href: '/admin/questions',
        icon: FileQuestion,
      },
    ],
  },
  {
    label: 'Battle Ops',
    icon: Swords,
    items: [
      {
        label: 'Rooms',
        description: 'Monitor lobby status, room members, team slots, role selection and ready checks.',
        href: '/admin/rooms',
        icon: DoorOpen,
      },
      {
        label: 'Battles',
        description: 'Inspect battle sessions, question snapshots, answer submissions and final results.',
        href: '/admin/battles',
        icon: Swords,
      },
      {
        label: 'Ranking',
        description: 'Review rank profiles, star changes, tier movement and leaderboard state.',
        href: '/admin/ranking',
        icon: Trophy,
      },
    ],
  },
  {
    label: 'Trust Center',
    icon: ShieldCheck,
    items: [
      {
        label: 'Blockchain Evidence',
        description: 'Verify resultHash, txHash, block number, chain status and smart-contract trace.',
        href: '/admin/evidence',
        icon: ShieldCheck,
      },
      {
        label: 'Reward Ledger',
        description: 'Audit BrainPoint wallet movements, settlement status and reward breakdowns.',
        href: '/admin/rewards',
        icon: Coins,
      },
      {
        label: 'Audit Logs',
        description: 'Review operational events used for gameplay and reward traceability.',
        href: '/admin/audit-logs',
        icon: ScrollText,
      },
    ],
  },
  {
    label: 'Economy',
    icon: WalletCards,
    items: [
      {
        label: 'Shop / Inventory',
        description: 'Manage BrainPoint shop items and inspect player inventory state.',
        href: '/admin/shop',
        icon: ShoppingBag,
      },
    ],
  },
  {
    label: 'Users',
    icon: Users,
    items: [
      {
        label: 'Learner Accounts',
        description: 'Inspect learner profiles, roles, account status, wallets and rank readiness.',
        href: '/admin/users/learners',
        icon: Users,
      },
    ],
  },
  {
    label: 'System',
    icon: Settings,
    items: [
      {
        label: 'Settings',
        description: 'Check runtime endpoints, auth bridge, battle API and frontend environment.',
        href: '/admin/settings',
        icon: Settings,
      },
    ],
  },
];

function isActive(pathname: string, group: NavGroup) {
  if (group.href) return pathname === group.href;
  return group.items?.some((item) => pathname === item.href || pathname.startsWith(`${item.href}/`));
}

export function AdminTopNav() {
  const pathname = usePathname();
  const router = useRouter();
  const [open, setOpen] = useState<string | null>(null);
  const [dark, setDark] = useState(false);
  const headerRef = useRef<HTMLElement | null>(null);

  useEffect(() => {
    const stored = localStorage.getItem('brainbattle_admin_theme');
    setDark(stored === 'dark');
  }, []);

  useEffect(() => {
    document.documentElement.classList.toggle('dark', dark);
    localStorage.setItem('brainbattle_admin_theme', dark ? 'dark' : 'light');
  }, [dark]);

  useEffect(() => {
    setOpen(null);
  }, [pathname]);

  useEffect(() => {
    function onPointerDown(event: MouseEvent) {
      if (!headerRef.current?.contains(event.target as Node)) setOpen(null);
    }

    function onEscape(event: KeyboardEvent) {
      if (event.key === 'Escape') setOpen(null);
    }

    document.addEventListener('mousedown', onPointerDown);
    document.addEventListener('keydown', onEscape);
    return () => {
      document.removeEventListener('mousedown', onPointerDown);
      document.removeEventListener('keydown', onEscape);
    };
  }, []);

  async function logout() {
    await signOutAdmin();
    router.replace('/sign-in');
  }

  return (
    <header
      ref={headerRef}
      className="sticky top-0 z-50 border-b border-[var(--bb-border)] bg-[var(--bb-bg)]/82 px-4 py-2.5 backdrop-blur-2xl md:px-6"
    >
      <div className="mx-auto grid max-w-[1480px] grid-cols-[auto_1fr_auto] items-center gap-3">
        <Link
          href="/admin"
          className="bb-glass group flex h-12 shrink-0 items-center gap-2 rounded-[22px] px-3 shadow-sm transition hover:-translate-y-0.5 hover:shadow-[var(--bb-shadow-glow)]"
          aria-label="Go to BrainBattle Admin home"
        >
          <span className="relative h-9 w-9 overflow-hidden rounded-xl bg-gradient-to-br from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] p-1.5 shadow-lg">
            <Image
              src="/images/brainbattle_logo_really_pink.png"
              alt="BrainBattle"
              fill
              className="object-contain p-1"
              priority
            />
          </span>
          <span className="hidden leading-tight sm:block">
            <span className="bb-gradient-text block text-[15px] font-black tracking-tight">BrainBattle</span>
            <span className="block text-[9px] font-black uppercase tracking-[0.18em] text-[var(--bb-muted)]">
              Admin Operations
            </span>
          </span>
        </Link>

        <nav className="bb-glass relative mx-auto flex h-12 max-w-full items-center justify-center gap-1 rounded-[24px] px-1.5 shadow-sm">
          {navGroups.map((group) => {
            const Icon = group.icon;
            const active = isActive(pathname, group);
            const expanded = open === group.label;

            if (group.href) {
              return (
                <Link
                  key={group.label}
                  href={group.href}
                  className={cn(
                    'inline-flex h-9 shrink-0 items-center gap-2 rounded-xl px-3 text-sm font-black transition',
                    active
                      ? 'bg-[var(--bb-surface-strong)] text-[var(--bb-text)] shadow-md'
                      : 'text-[var(--bb-muted)] hover:bg-[var(--bb-surface-soft)] hover:text-[var(--bb-text)]',
                  )}
                >
                  <Icon className="h-4 w-4" />
                  <span className="hidden lg:inline">{group.label}</span>
                </Link>
              );
            }

            return (
              <div key={group.label} className="relative shrink-0">
                <button
                  type="button"
                  aria-expanded={expanded}
                  onClick={() => setOpen((value) => (value === group.label ? null : group.label))}
                  className={cn(
                    'inline-flex h-9 items-center gap-2 rounded-xl px-3 text-sm font-black transition',
                    active || expanded
                      ? 'bg-[var(--bb-surface-strong)] text-[var(--bb-text)] shadow-md'
                      : 'text-[var(--bb-muted)] hover:bg-[var(--bb-surface-soft)] hover:text-[var(--bb-text)]',
                  )}
                >
                  <Icon className="h-4 w-4" />
                  <span className="hidden xl:inline">{group.label}</span>
                  <ChevronDown className={cn('h-3.5 w-3.5 transition', expanded && 'rotate-180')} />
                </button>

                {expanded ? (
                  <div className="absolute left-1/2 top-[48px] z-[70] w-[min(430px,calc(100vw-32px))] -translate-x-1/2 rounded-[28px] border border-[var(--bb-border)] bg-[var(--bb-surface)] p-3 shadow-2xl backdrop-blur-2xl">
                    <div className="px-2 pb-2 pt-1">
                      <p className="text-xs font-black uppercase tracking-[0.18em] text-[var(--bb-muted)]">
                        {group.label}
                      </p>
                    </div>
                    <div className="grid gap-2">
                      {group.items?.map((item) => {
                        const ItemIcon = item.icon;
                        const itemActive = pathname === item.href || pathname.startsWith(`${item.href}/`);
                        return (
                          <Link
                            key={item.href}
                            href={item.href}
                            className={cn(
                              'group flex items-start gap-3 rounded-3xl border border-transparent p-3 transition',
                              itemActive
                                ? 'border-[var(--bb-primary-border)] bg-[var(--bb-pink-soft)]'
                                : 'hover:border-[var(--bb-border)] hover:bg-[var(--bb-surface-soft)]',
                            )}
                          >
                            <span className="grid h-10 w-10 shrink-0 place-items-center rounded-2xl bg-gradient-to-br from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] text-white shadow-md">
                              <ItemIcon className="h-4 w-4" />
                            </span>
                            <span className="min-w-0">
                              <span className="block text-sm font-black text-[var(--bb-text)]">{item.label}</span>
                              <span className="mt-1 block text-xs leading-5 text-[var(--bb-muted)]">
                                {item.description}
                              </span>
                            </span>
                          </Link>
                        );
                      })}
                    </div>
                  </div>
                ) : null}
              </div>
            );
          })}
        </nav>

        <div className="flex shrink-0 items-center justify-end gap-2">
          <button
            type="button"
            onClick={() => setDark((value) => !value)}
            className="bb-glass grid h-10 w-10 place-items-center rounded-full text-[var(--bb-text)] transition hover:-translate-y-0.5"
            aria-label="Toggle theme"
          >
            {dark ? <Sun className="h-4 w-4" /> : <Moon className="h-4 w-4" />}
          </button>
          <button
            type="button"
            onClick={logout}
            className="bb-glass inline-flex h-10 items-center gap-2 rounded-full px-3.5 text-sm font-black text-[var(--bb-muted)] transition hover:-translate-y-0.5 hover:text-[var(--bb-red)]"
          >
            <LogOut className="h-4 w-4" />
            <span className="hidden xl:inline">Sign out</span>
          </button>
        </div>
      </div>
    </header>
  );
}