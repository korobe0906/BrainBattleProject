'use client';

import Link from 'next/link';
import Image from 'next/image';
import { usePathname } from 'next/navigation';
import { ChevronRight } from 'lucide-react';
import { cn } from '@/lib/utils';
import { MenuItem, menu } from './sidebar.menu';

export default function Sidebar() {
  const pathname = usePathname();

  const isChildActive = (children: MenuItem[]) =>
    children.some((item) => item.href && pathname.startsWith(item.href));

  return (
    <aside className="h-screen w-[284px] p-4">
      <div className="bb-glass flex h-full flex-col rounded-[32px] p-4 shadow-2xl">
        <div className="flex items-center gap-3 px-3 py-4">
          <div className="relative h-11 w-11 shrink-0">
            <Image
              src="/images/brainbattle_logo_really_pink.png"
              alt="BrainBattle"
              fill
              className="object-contain"
            />
          </div>

          <div>
            <p className="bb-gradient-text text-lg font-black tracking-wide">
              BrainBattle
            </p>
            <p className="text-xs font-bold uppercase tracking-[0.18em] text-[var(--bb-muted)]">
              Admin Console
            </p>
          </div>
        </div>

        <nav className="mt-4 flex-1 space-y-2 overflow-y-auto pr-1">
          {menu.map((item) => {
            if (item.children?.length) {
              const active = isChildActive(item.children);

              return (
                <div key={item.label}>
                  <div
                    className={cn(
                      'flex items-center gap-3 rounded-2xl px-4 py-3 text-sm font-black',
                      active
                        ? 'text-[var(--bb-text)]'
                        : 'text-[var(--bb-muted)]',
                    )}
                  >
                    <item.icon className="h-5 w-5 text-[var(--bb-purple)]" />
                    <span className="flex-1">{item.label}</span>
                    <ChevronRight
                      className={cn(
                        'h-4 w-4 transition',
                        active && 'rotate-90',
                      )}
                    />
                  </div>

                  <div className="mt-1 space-y-1 pl-4">
                    {item.children.map((child) => {
                      const childActive =
                        !!child.href && pathname.startsWith(child.href);

                      return (
                        <Link
                          key={child.label}
                          href={child.href!}
                          className={cn(
                            'flex items-center gap-3 rounded-2xl px-4 py-2.5 text-sm font-bold transition',
                            childActive
                              ? 'bg-gradient-to-r from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] text-white shadow-lg'
                              : 'text-[var(--bb-muted)] hover:bg-white/10 hover:text-[var(--bb-text)]',
                          )}
                        >
                          <child.icon className="h-4 w-4" />
                          {child.label}
                        </Link>
                      );
                    })}
                  </div>
                </div>
              );
            }

            const active = item.href === pathname;

            return (
              <Link
                key={item.label}
                href={item.href!}
                className={cn(
                  'flex items-center gap-3 rounded-2xl px-4 py-3 text-sm font-black transition',
                  active
                    ? 'bg-gradient-to-r from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] text-white shadow-lg'
                    : 'text-[var(--bb-muted)] hover:bg-white/10 hover:text-[var(--bb-text)]',
                )}
              >
                <item.icon className="h-5 w-5" />
                {item.label}
              </Link>
            );
          })}
        </nav>

        <div className="mt-4 rounded-3xl border border-[var(--bb-border)] bg-black/5 p-4 dark:bg-white/5">
          <p className="text-sm font-black">Production Auth</p>
          <p className="mt-1 text-xs leading-5 text-[var(--bb-muted)]">
            Admin access is verified by Supabase token and backend roles.
          </p>
        </div>
      </div>
    </aside>
  );
}