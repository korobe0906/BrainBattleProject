import { LucideIcon } from 'lucide-react';
import { SurfaceCard } from './SurfaceCard';

export function MetricCard({
  icon: Icon,
  label,
  value,
  hint,
}: {
  icon: LucideIcon;
  label: string;
  value: string | number;
  hint?: string;
}) {
  return (
    <SurfaceCard className="p-5 transition hover:-translate-y-0.5 hover:border-[var(--bb-primary-border)] hover:shadow-[var(--bb-shadow-glow)]">
      <div className="flex items-start justify-between gap-3">
        <div>
          <p className="text-sm font-bold text-[var(--bb-muted)]">{label}</p>
          <p className="mt-2 text-3xl font-black">{value}</p>
          {hint ? <p className="mt-2 text-xs text-[var(--bb-muted)]">{hint}</p> : null}
        </div>
        <div className="rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-soft)] p-3 text-[var(--bb-pink)]">
          <Icon className="h-5 w-5" />
        </div>
      </div>
    </SurfaceCard>
  );
}
