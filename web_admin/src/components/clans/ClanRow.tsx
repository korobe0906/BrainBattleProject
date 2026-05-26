import { Clan, ClanStatus } from "@/types/clanGuild.types";

export function ClanStatusBadge({ status }: { status: ClanStatus }) {
  const map: Record<ClanStatus, { label: string; cls: string }> = {
    Active: {
      label: "Active",
      cls: "bg-emerald-100 text-emerald-700 ring-1 ring-emerald-300",
    },
    Inactive: {
      label: "Inactive",
      cls: "bg-gray-100 text-gray-700 ring-1 ring-gray-300",
    },
    Suspended: {
      label: "Suspended",
      cls: "bg-rose-100 text-rose-700 ring-1 ring-rose-300",
    },
  };

  return (
    <span
      className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${map[status].cls}`}
    >
      {map[status].label}
    </span>
  );
}

const fmtDate = (iso: string) => {
  const d = new Date(iso);
  return d.toLocaleDateString("en-US", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

export function ClanRow({
  clan,
  checked,
  onToggle,
}: {
  clan: Clan;
  checked: boolean;
  onToggle: () => void;
}) {
  return (
    <tr className="border-b border-gray-100 hover:bg-gray-50 transition">
      <td className="px-3 py-3 w-10 align-top">
        <input
          type="checkbox"
          checked={checked}
          onChange={onToggle}
          className="w-4 h-4 rounded border-gray-300 text-pink-600 focus:ring-pink-400/40"
        />
      </td>

      <td className="px-5 py-3">
        <div className="space-y-0.5">
          <div className="font-medium text-gray-900 text-sm">{clan.name}</div>
          <div className="text-xs text-gray-500">{clan.clanCode}</div>
        </div>
      </td>

      <td className="px-5 py-3">
        <div className="space-y-0.5">
          <div className="text-sm text-gray-900">{clan.leaderName}</div>
          <div className="text-xs text-gray-500">{clan.leaderId.substring(0, 8)}...</div>
        </div>
      </td>

      <td className="px-5 py-3 text-sm text-gray-600">{clan.membersCount}/{clan.maxMembers}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{clan.language}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{clan.region}</td>
      <td className="px-5 py-3 text-sm text-gray-600">Lv {clan.levelRequirement}+</td>

      <td className="px-5 py-3">
        <ClanStatusBadge status={clan.status} />
      </td>

      <td className="px-5 py-3 text-sm text-gray-600">{fmtDate(clan.createdAt)}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{fmtDate(clan.lastActiveAt)}</td>

      <td className="px-5 py-3 text-sm text-center">
        <div className="flex items-center justify-center gap-2">
          <button
            type={"button" as const}
            className="text-pink-600 hover:text-pink-700 text-sm font-medium"
          >
            View
          </button>
          <button
            type={"button" as const}
            className="text-blue-600 hover:text-blue-700 text-sm font-medium"
          >
            Edit
          </button>
          {clan.status !== "Suspended" && (
            <button
              type={"button" as const}
              className="text-orange-600 hover:text-orange-700 text-sm font-medium"
            >
              Suspend
            </button>
          )}
          <button
            type={"button" as const}
            className="text-rose-600 hover:text-rose-700 text-sm font-medium"
          >
            Delete
          </button>
        </div>
      </td>
    </tr>
  );
}
