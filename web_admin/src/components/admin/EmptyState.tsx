import { Inbox } from 'lucide-react';

export function EmptyState({ title = 'Không có dữ liệu', description = 'Backend chưa trả về bản ghi nào cho bộ lọc hiện tại.' }: { title?: string; description?: string }) {
  return (
    <div className="grid min-h-[180px] place-items-center rounded-3xl border border-dashed border-[var(--bb-border)] bg-[var(--bb-surface-soft)] p-8 text-center">
      <div>
        <div className="mx-auto grid h-12 w-12 place-items-center rounded-2xl bg-[var(--bb-pink-soft)] text-[var(--bb-pink)]">
          <Inbox className="h-6 w-6" />
        </div>
        <p className="mt-4 text-base font-black">{title}</p>
        <p className="mt-2 max-w-md text-sm leading-6 text-[var(--bb-muted)]">{description}</p>
      </div>
    </div>
  );
}
