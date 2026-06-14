export function JsonPanel({ value, maxHeight = 380 }: { value: unknown; maxHeight?: number }) {
  return (
    <pre style={{ maxHeight }} className="bb-scrollbar overflow-auto rounded-2xl border border-[var(--bb-border)] bg-black/5 p-4 text-xs leading-5 text-[var(--bb-muted-strong)] dark:bg-white/5">
      {JSON.stringify(value ?? null, null, 2)}
    </pre>
  );
}
