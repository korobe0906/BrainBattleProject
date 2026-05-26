"use client";

import { ChatMessage } from "@/types/clanGuild.types";
import { MessageRow } from "./MessageRow";

interface ChatTableProps {
  messages: ChatMessage[];
  selectedIds: Set<string>;
  onToggleSelect: (id: string) => void;
  onToggleAll: (checked: boolean) => void;
}

export function ChatTable({
  messages,
  selectedIds,
  onToggleSelect,
  onToggleAll,
}: ChatTableProps) {
  return (
    <div className="overflow-x-auto bg-white rounded-2xl border border-gray-200 shadow-sm">
      <table className="w-full text-left">
        <thead>
          <tr className="text-left text-gray-600 text-sm border-b border-gray-200">
            <th className="px-3 py-3 w-10">
              <input
                type="checkbox"
                checked={messages.length > 0 && messages.every((m) => selectedIds.has(m.id))}
                ref={(el: HTMLInputElement | null) => {
                  if (!el) return;
                  const all = messages.length > 0 && messages.every((m) => selectedIds.has(m.id));
                  const some = messages.some((m) => selectedIds.has(m.id));
                  el.indeterminate = !all && some;
                }}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => onToggleAll(e.target.checked)}
              />
            </th>
            <th className="px-3 py-3">Clan</th>
            <th className="px-3 py-3">Sender</th>
            <th className="px-3 py-3">Message</th>
            <th className="px-3 py-3">Type</th>
            <th className="px-3 py-3">Status</th>
            <th className="px-3 py-3">Sent At</th>
            <th className="px-3 py-3">Actions</th>
          </tr>
        </thead>
        <tbody>
          {messages.map((msg) => (
            <MessageRow
              key={msg.id}
              msg={msg}
              checked={selectedIds.has(msg.id)}
              onToggle={() => onToggleSelect(msg.id)}
            />
          ))}
        </tbody>
      </table>
    </div>
  );
}
