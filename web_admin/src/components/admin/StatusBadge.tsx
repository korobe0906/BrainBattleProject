import { cn } from '@/lib/utils';

const toneMap: Record<string, string> = {
  APPROVED: 'bb-badge-green',
  ACTIVE: 'bb-badge-green',
  FINISHED: 'bb-badge-green',
  CONFIRMED: 'bb-badge-green',
  WIN: 'bb-badge-green',
  READY: 'bb-badge-green',
  DRAFT: 'bb-badge-muted',
  WAITING: 'bb-badge-blue',
  PLAYING: 'bb-badge-blue',
  RUNNING: 'bb-badge-blue',
  PENDING_REVIEW: 'bb-badge-yellow',
  PENDING: 'bb-badge-yellow',
  SUBMITTED: 'bb-badge-yellow',
  REJECTED: 'bb-badge-red',
  ARCHIVED: 'bb-badge-muted',
  CANCELLED: 'bb-badge-red',
  FAILED: 'bb-badge-red',
  BLOCKED: 'bb-badge-red',
  LOSE: 'bb-badge-red',
  DRAW: 'bb-badge-yellow',
};

export function StatusBadge({ value, className }: { value?: string | null; className?: string }) {
  const key = String(value ?? 'UNKNOWN').toUpperCase();
  return <span className={cn('bb-badge', toneMap[key] ?? 'bb-badge-muted', className)}>{key}</span>;
}
