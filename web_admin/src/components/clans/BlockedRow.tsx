"use client";

import { BlockedClan } from "@/types/clanGuild.types";
import { Eye, Unlock, AlertCircle } from "lucide-react";

function fmtDate(iso: string) {
  const d = new Date(iso);
  return `${d.getMonth() + 1}/${d.getDate()}/${d.getFullYear()}`;
}

interface BlockedRowProps {
  blocked: BlockedClan;
  checked: boolean;
  onToggle: () => void;
}

export function BlockedRow({ blocked, checked, onToggle }: BlockedRowProps) {
  const isPermanent = blocked.duration === "Permanent";
  const isExpired = blocked.expiresAt && new Date(blocked.expiresAt) < new Date();

  return (
    <tr className="hover:bg-gray-50 border-b border-gray-100 transition">
      <td className="px-3 py-3 w-10 align-top">
        <input type="checkbox" checked={checked} onChange={onToggle} />
      </td>

      <td className="px-3 py-3">
        <div className="text-sm font-medium text-gray-900">{blocked.clanName}</div>
        <div className="text-xs text-gray-500">{blocked.clanCode}</div>
      </td>

      <td className="px-3 py-3">
        <span
          className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ring-1 ring-inset ${
            blocked.reason === "Spam"
              ? "bg-amber-100 text-amber-700 ring-amber-300"
              : blocked.reason === "Fraud"
                ? "bg-rose-100 text-rose-700 ring-rose-300"
                : blocked.reason === "Toxicity"
                  ? "bg-orange-100 text-orange-700 ring-orange-300"
                  : blocked.reason === "Abuse"
                    ? "bg-red-100 text-red-700 ring-red-300"
                    : "bg-gray-100 text-gray-700 ring-gray-300"
          }`}
        >
          {blocked.reason}
        </span>
      </td>

      <td className="px-3 py-3">
        <span
          className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ring-1 ring-inset ${
            isPermanent
              ? "bg-rose-100 text-rose-700 ring-rose-300"
              : "bg-blue-100 text-blue-700 ring-blue-300"
          }`}
        >
          {blocked.duration}
        </span>
      </td>

      <td className="px-3 py-3 max-w-xs">
        <div className="text-sm text-gray-700 truncate">{blocked.note || "—"}</div>
      </td>

      <td className="px-3 py-3 text-sm text-gray-600">{fmtDate(blocked.blockedAt)}</td>

      <td className="px-3 py-3 text-sm text-gray-600">
        {blocked.expiresAt ? (
          <span className={isExpired ? "text-rose-600 font-medium" : ""}>
            {fmtDate(blocked.expiresAt)}
            {isExpired && <AlertCircle className="w-3 h-3 inline ml-1" />}
          </span>
        ) : (
          "—"
        )}
      </td>

      <td className="px-3 py-3 text-sm text-gray-600">{blocked.blockedBy}</td>

      <td className="px-3 py-3">
        <div className="flex items-center gap-1">
          <button
            type={"button" as const}
            className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-pink-600 transition"
            title="View Details"
          >
            <Eye className="w-4 h-4" />
          </button>
          <button
            type={"button" as const}
            className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-emerald-600 transition"
            title="Unblock"
          >
            <Unlock className="w-4 h-4" />
          </button>
        </div>
      </td>
    </tr>
  );
}
