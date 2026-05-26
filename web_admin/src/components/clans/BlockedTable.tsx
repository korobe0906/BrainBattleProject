"use client";

import { BlockedClan } from "@/types/clanGuild.types";
import { BlockedRow } from "./BlockedRow";

interface BlockedTableProps {
  blocked: BlockedClan[];
  selectedIds: Set<string>;
  onToggleSelect: (id: string) => void;
  onToggleAll: (checked: boolean) => void;
}

export function BlockedTable({
  blocked,
  selectedIds,
  onToggleSelect,
  onToggleAll,
}: BlockedTableProps) {
  return (
    <div className="overflow-x-auto bg-white rounded-2xl border border-gray-200 shadow-sm">
      <table className="w-full text-left">
        <thead>
          <tr className="text-left text-gray-600 text-sm border-b border-gray-200">
            <th className="px-3 py-3 w-10">
              <input
                type="checkbox"
                checked={blocked.length > 0 && blocked.every((b) => selectedIds.has(b.id))}
                ref={(el: HTMLInputElement | null) => {
                  if (!el) return;
                  const all = blocked.length > 0 && blocked.every((b) => selectedIds.has(b.id));
                  const some = blocked.some((b) => selectedIds.has(b.id));
                  el.indeterminate = !all && some;
                }}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => onToggleAll(e.target.checked)}
              />
            </th>
            <th className="px-3 py-3">Clan</th>
            <th className="px-3 py-3">Reason</th>
            <th className="px-3 py-3">Duration</th>
            <th className="px-3 py-3">Note</th>
            <th className="px-3 py-3">Blocked At</th>
            <th className="px-3 py-3">Expires At</th>
            <th className="px-3 py-3">Blocked By</th>
            <th className="px-3 py-3">Actions</th>
          </tr>
        </thead>
        <tbody>
          {blocked.map((b) => (
            <BlockedRow
              key={b.id}
              blocked={b}
              checked={selectedIds.has(b.id)}
              onToggle={() => onToggleSelect(b.id)}
            />
          ))}
        </tbody>
      </table>
    </div>
  );
}
