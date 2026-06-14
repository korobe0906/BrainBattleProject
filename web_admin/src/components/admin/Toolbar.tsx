import { Search } from 'lucide-react';

export function SearchBox({ value, onChange, placeholder = 'Search...' }: { value: string; onChange: (value: string) => void; placeholder?: string }) {
  return (
    <label className="flex min-w-0 flex-1 items-center gap-2 rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-strong)] px-4 py-3 text-sm shadow-sm">
      <Search className="h-4 w-4 text-[var(--bb-muted)]" />
      <input value={value} onChange={(e) => onChange(e.target.value)} placeholder={placeholder} className="min-w-0 flex-1 bg-transparent font-semibold outline-none placeholder:text-[var(--bb-muted)]" />
    </label>
  );
}

export function SelectFilter({ value, onChange, options }: { value: string; onChange: (value: string) => void; options: string[] }) {
  return (
    <select value={value} onChange={(e) => onChange(e.target.value)} className="rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-strong)] px-4 py-3 text-sm font-black outline-none">
      {options.map((option) => <option key={option} value={option}>{option}</option>)}
    </select>
  );
}
