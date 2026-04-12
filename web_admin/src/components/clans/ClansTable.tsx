import { Clan } from "@/types/clanGuild.types";
import { ClanRow } from "./ClanRow";

export function ClansTable({
  clans,
  selectedIds,
  onToggleSelect,
  onToggleAll,
}: {
  clans: Clan[];
  selectedIds: Set<string>;
  onToggleSelect: (id: string) => void;
  onToggleAll: (checked: boolean) => void;
}) {
  return (
    <div className="overflow-x-auto rounded-2xl bg-white border border-gray-200 shadow-sm">
      <table className="min-w-full">
        <thead>
          <tr className="text-left text-gray-600 text-sm border-b border-gray-200">
            <th className="px-3 py-3 w-10">
              <input
                type="checkbox"
                checked={
                  clans.length > 0 &&
                  clans.every((c) => selectedIds.has(c.id))
                }
                ref={(el: HTMLInputElement | null) => {
                  if (!el) return;
                  const all = clans.length > 0 &&
                    clans.every((c) => selectedIds.has(c.id));
                  const some = clans.some((c) => selectedIds.has(c.id));
                  el.indeterminate = !all && some;
                }}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => onToggleAll(e.target.checked)}
                className="w-4 h-4 rounded border-gray-300 text-pink-600 focus:ring-pink-400/40"
              />
            </th>
            <th className="px-5 py-3 font-medium">Clan</th>
            <th className="px-5 py-3 font-medium">Leader</th>
            <th className="px-5 py-3 font-medium">Members</th>
            <th className="px-5 py-3 font-medium">Language</th>
            <th className="px-5 py-3 font-medium">Region</th>
            <th className="px-5 py-3 font-medium">Min Level</th>
            <th className="px-5 py-3 font-medium">Status</th>
            <th className="px-5 py-3 font-medium">Created</th>
            <th className="px-5 py-3 font-medium">Last Active</th>
            <th className="px-5 py-3 font-medium text-center">Actions</th>
          </tr>
        </thead>
        <tbody>
          {clans.map((clan) => (
            <ClanRow
              key={clan.id}
              clan={clan}
              checked={selectedIds.has(clan.id)}
              onToggle={() => onToggleSelect(clan.id)}
            />
          ))}
        </tbody>
      </table>
    </div>
  );
}
