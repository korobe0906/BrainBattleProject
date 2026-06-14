import { ButtonHTMLAttributes } from 'react';
import { cn } from '@/lib/utils';

export function ActionButton({ className, variant = 'primary', ...props }: ButtonHTMLAttributes<HTMLButtonElement> & { variant?: 'primary' | 'secondary' | 'danger' }) {
  return (
    <button
      {...props}
      className={cn(
        'inline-flex items-center justify-center gap-2 rounded-2xl px-4 py-2.5 text-sm font-black transition disabled:cursor-not-allowed disabled:opacity-60',
        variant === 'primary' && 'bg-gradient-to-r from-[var(--bb-pink)] via-[var(--bb-purple)] to-[var(--bb-cyan)] text-white shadow-lg',
        variant === 'secondary' && 'border border-[var(--bb-border)] bg-[var(--bb-surface-strong)] text-[var(--bb-text)] hover:bg-[var(--bb-surface-soft)]',
        variant === 'danger' && 'border border-[var(--bb-red)]/30 bg-[var(--bb-red)]/10 text-[var(--bb-red)]',
        className,
      )}
    />
  );
}
