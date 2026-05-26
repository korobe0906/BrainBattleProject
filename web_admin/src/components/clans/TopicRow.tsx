"use client";

import { Topic } from "@/types/clanGuild.types";
import { Edit2, Eye, Ban } from "lucide-react";

function TopicStatusBadge({ status }: { status: Topic["status"] }) {
  const colors = {
    Active: "bg-emerald-100 text-emerald-700 ring-emerald-300",
    Inactive: "bg-gray-100 text-gray-700 ring-gray-300",
    Banned: "bg-rose-100 text-rose-700 ring-rose-300",
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

interface TopicRowProps {
  topic: Topic;
  checked: boolean;
  onToggle: () => void;
}

export function TopicRow({ topic, checked, onToggle }: TopicRowProps) {
  return (
    <tr className="hover:bg-gray-50 border-b border-gray-100 transition">
      <td className="px-3 py-3 w-10 align-top">
        <input type="checkbox" checked={checked} onChange={onToggle} />
      </td>

      <td className="px-3 py-3">
        <div className="text-sm font-medium text-gray-900">{topic.name}</div>
        {topic.synonyms && topic.synonyms.length > 0 && (
          <div className="text-xs text-gray-500 mt-1">
            Synonyms: {topic.synonyms.join(", ")}
          </div>
        )}
      </td>

      <td className="px-3 py-3">
        <span className="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-700">
          {topic.category}
        </span>
      </td>

      <td className="px-3 py-3 max-w-xs">
        <div className="text-sm text-gray-700 truncate">{topic.description || "—"}</div>
      </td>

      <td className="px-3 py-3 text-sm text-gray-900 font-medium">{topic.usageCount}</td>

      <td className="px-3 py-3">
        <TopicStatusBadge status={topic.status} />
      </td>

      <td className="px-3 py-3 text-sm text-gray-600">{fmtDate(topic.createdAt)}</td>

      <td className="px-3 py-3 text-sm text-gray-600">{fmtDate(topic.updatedAt)}</td>

      <td className="px-3 py-3">
        <div className="flex items-center gap-1">
          <button
            type={"button" as const}
            className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-pink-600 transition"
            title="View"
          >
            <Eye className="w-4 h-4" />
          </button>
          <button
            type={"button" as const}
            className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-blue-600 transition"
            title="Edit"
          >
            <Edit2 className="w-4 h-4" />
          </button>
          {topic.status !== "Banned" && (
            <button
              type={"button" as const}
              className="p-1.5 rounded-lg hover:bg-gray-100 text-gray-600 hover:text-rose-600 transition"
              title="Ban"
            >
              <Ban className="w-4 h-4" />
            </button>
          )}
        </div>
      </td>
    </tr>
  );
}
