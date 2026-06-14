import { LucideIcon } from 'lucide-react';
import { SurfaceCard } from './SurfaceCard';

export function PageHero({
  eyebrow,
  title,
  description,
  icon: Icon,
  actions,
}: {
  eyebrow: string;
  title: string;
  description: string;
  icon: LucideIcon;
  actions?: React.ReactNode;
}) {
  return (
    <SurfaceCard highlight className="p-6 md:p-8">
      <div className="flex flex-col gap-5 xl:flex-row xl:items-center xl:justify-between">
        <div className="flex gap-4">
          <div className="grid h-14 w-14 shrink-0 place-items-center rounded-3xl bg-gradient-to-br from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] text-white shadow-[0_18px_42px_rgba(255,93,174,0.28)]">
            <Icon className="h-7 w-7" />
          </div>
          <div className="min-w-0">
            <p className="text-xs font-black uppercase tracking-[0.25em] text-[var(--bb-muted)]">
              {eyebrow}
            </p>
            <h1 className="mt-1 text-2xl font-black tracking-tight md:text-4xl">
              {title}
            </h1>
            <p className="mt-3 max-w-3xl text-sm leading-6 text-[var(--bb-muted)]">
              {description}
            </p>
          </div>
        </div>
        {actions ? <div className="shrink-0">{actions}</div> : null}
      </div>
    </SurfaceCard>
  );
}
