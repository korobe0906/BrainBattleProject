"use client";

import { Topic } from "@/types/clanGuild.types";
import { TopicRow } from "./TopicRow";

interface TopicsTableProps {
  topics: Topic[];
  selectedIds: Set<string>;
  onToggleSelect: (id: string) => void;
  onToggleAll: (checked: boolean) => void;
}

export function TopicsTable({
  topics,
  selectedIds,
  onToggleSelect,
  onToggleAll,
}: TopicsTableProps) {
  return (
    <div className="overflow-x-auto bg-white rounded-2xl border border-gray-200 shadow-sm">
      <table className="w-full text-left">
        <thead>
          <tr className="text-left text-gray-600 text-sm border-b border-gray-200">
            <th className="px-3 py-3 w-10">
              <input
                type="checkbox"
                checked={topics.length > 0 && topics.every((t) => selectedIds.has(t.id))}
                ref={(el: HTMLInputElement | null) => {
                  if (!el) return;
                  const all = topics.length > 0 && topics.every((t) => selectedIds.has(t.id));
                  const some = topics.some((t) => selectedIds.has(t.id));
                  el.indeterminate = !all && some;
                }}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => onToggleAll(e.target.checked)}
              />
            </th>
            <th className="px-3 py-3">Name</th>
            <th className="px-3 py-3">Category</th>
            <th className="px-3 py-3">Description</th>
            <th className="px-3 py-3">Usage</th>
            <th className="px-3 py-3">Status</th>
            <th className="px-3 py-3">Created</th>
            <th className="px-3 py-3">Updated</th>
            <th className="px-3 py-3">Actions</th>
          </tr>
        </thead>
        <tbody>
          {topics.map((t) => (
            <TopicRow
              key={t.id}
              topic={t}
              checked={selectedIds.has(t.id)}
              onToggle={() => onToggleSelect(t.id)}
            />
          ))}
        </tbody>
      </table>
    </div>
  );
}
