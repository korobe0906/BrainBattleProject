import { ReactNode } from 'react';
import { cn } from '@/lib/utils';

export function SurfaceCard({
  children,
  className,
  highlight = false,
}: {
  children: ReactNode;
  className?: string;
  highlight?: boolean;
}) {
  return (
    <section
      className={cn(
        'bb-surface-card',
        highlight && 'bb-surface-card-highlight',
        className,
      )}
    >
      {children}
    </section>
  );
}
