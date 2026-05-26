"use client";

import { ChatMessage } from "@/types/clanGuild.types";
import { Eye, EyeOff, Trash2, Flag } from "lucide-react";

function MessageStatusBadge({ status }: { status: ChatMessage["status"] }) {
  const colors = {
    Normal: "bg-emerald-100 text-emerald-700 ring-emerald-300",
    Flagged: "bg-amber-100 text-amber-700 ring-amber-300",
    Hidden: "bg-gray-100 text-gray-700 ring-gray-300",
    Deleted: "bg-rose-100 text-rose-700 ring-rose-300",
  };
  return (
    <span
      className={`inline-flex items-center px-2 py-1 rounded-full text-xs font-medium ring-1 ring-inset ${colors[status]}`}
    >
      {status}
    </span>
  );
}

function fmtDate(iso: string) {
  const d = new Date(iso);
  return `${d.getMonth() + 1}/${d.getDate()}/${d.getFullYear()}`;
}

function fmtTime(iso: string) {
  const d = new Date(iso);
  return d.toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit" });
}

interface MessageRowProps {
  msg: ChatMessage;
  checked: boolean;
  onToggle: () => void;
}

export function MessageRow({ msg, checked, onToggle }: MessageRowProps) {
  return (
    <tr className="hover:bg-gray-50 border-b border-gray-100 transition">
      <td className="px-3 py-3 w-10 align-top">
        <input type="checkbox" checked={checked} onChange={onToggle} />
      </td>

      <td className="px-3 py-3">
        <div className="text-sm font-medium text-gray-900">{msg.clanName}</div>
        <div className="text-xs text-gray-500">{msg.clanCode}</div>
      </td>

      <td className="px-3 py-3">
        <div className="text-sm font-medium text-gray-900">{msg.senderName}</div>
        <div className="text-xs text-gray-500">ID: {msg.senderId.slice(0, 8)}...</div>
      </td>

      <td className="px-3 py-3 max-w-xs">
        <div className="text-sm text-gray-700 truncate">{msg.messagePreview}</div>
      </td>

      <td className="px-3 py-3">
        <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-700">
          {msg.messageType}
        </span>
      </td>

      <td className="px-3 py-3">
        <MessageStatusBadge status={msg.status} />
        {msg.flagReason && (
          <div className="text-xs text-amber-600 mt-1">
            <Flag className="w-3 h-3 inline mr-1" />
            {msg.flagReason}
          </div>
        )}
      </td>

      <td className="px-3 py-3 text-sm text-gray-600">
        {fmtDate(msg.sentAt)}
        <div className="text-xs text-gray-500">{fmtTime(msg.sentAt)}</div>
      </td>

      <td className="px-3 py-3">
        <div className="flex items-center gap-1">
          <button
            type={"button" as const}
            className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-pink-600 transition"
            title="View"
          >
            <Eye className="w-4 h-4" />
          </button>
          {msg.status !== "Hidden" && (
            <button
              type={"button" as const}
              className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-amber-600 transition"
              title="Hide"
            >
              <EyeOff className="w-4 h-4" />
            </button>
          )}
          <button
            type={"button" as const}
            className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-rose-600 transition"
            title="Delete"
          >
            <Trash2 className="w-4 h-4" />
          </button>
        </div>
      </td>
    </tr>
  );
}
