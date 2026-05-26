"use client";

import { useEffect, useMemo, useState } from "react";
import { BlockedHeader } from "@/components/clans/BlockedHeader";
import { BlockedToolbar } from "@/components/clans/BlockedToolbar";
import { BlockedTable } from "@/components/clans/BlockedTable";
import { BlockedClan, BlockReason, BlockDuration } from "@/types/clanGuild.types";
import { mockBlockedClans } from "@/mock/clanGuild/blocked.mock";

const ITEMS_PER_PAGE = 20;

export default function BlockedClansPage() {
  const [blocked, setBlocked] = useState<BlockedClan[]>([]);
  const [q, setQ] = useState("");
  const [reason, setReason] = useState<BlockReason | "All">("All");
  const [duration, setDuration] = useState<BlockDuration | "All">("All");
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    setBlocked(mockBlockedClans);
  }, []);

  const filtered = useMemo(() => {
    return blocked.filter((b) => {
      const matchesQ =
        q === "" ||
        b.clanName.toLowerCase().includes(q.toLowerCase()) ||
        b.clanCode.toLowerCase().includes(q.toLowerCase());

      const matchesReason = reason === "All" || b.reason === reason;
      const matchesDuration = duration === "All" || b.duration === duration;

      return matchesQ && matchesReason && matchesDuration;
    });
  }, [blocked, q, reason, duration]);

  const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
  const paginatedBlocked = filtered.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  const handleToggleSelect = (id: string) => {
    const newSelected = new Set(selectedIds);
    if (newSelected.has(id)) {
      newSelected.delete(id);
    } else {
      newSelected.add(id);
    }
    setSelectedIds(newSelected);
  };

  const handleToggleAll = (checked: boolean) => {
    if (checked) {
      setSelectedIds(new Set(paginatedBlocked.map((b) => b.id)));
    } else {
      setSelectedIds(new Set());
    }
  };

  return (
    <div className="space-y-6">
      <BlockedHeader />

      <BlockedToolbar
        q={q}
        onQChange={setQ}
        reason={reason}
        onReasonChange={setReason}
        duration={duration}
        onDurationChange={setDuration}
      />

      <BlockedTable
        blocked={paginatedBlocked}
        selectedIds={selectedIds}
        onToggleSelect={handleToggleSelect}
        onToggleAll={handleToggleAll}
      />

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filtered.length)} of {filtered.length} blocked clans
        </div>
        <div className="flex gap-2">
          <button
            type={"button" as const}
            onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
            disabled={currentPage === 1}
            className="px-3 py-1 rounded-lg border border-gray-200 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50"
          >
            Previous
          </button>
          <div className="flex items-center gap-1">
            {Array.from({ length: totalPages }).map((_, i) => (
              <button
                key={i}
                type={"button" as const}
                onClick={() => setCurrentPage(i + 1)}
                className={`px-2 py-1 rounded text-sm ${
                  currentPage === i + 1
                    ? "bg-pink-600 text-white"
                    : "border border-gray-200 text-gray-700 hover:bg-gray-50"
                }`}
              >
                {i + 1}
              </button>
            ))}
          </div>
          <button
            type={"button" as const}
            onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
            disabled={currentPage === totalPages}
            className="px-3 py-1 rounded-lg border border-gray-200 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50"
          >
            Next
          </button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Total Blocked</div>
          <div className="text-2xl font-bold text-rose-600 mt-2">{blocked.length}</div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Temporary</div>
          <div className="text-2xl font-bold text-blue-600 mt-2">
            {blocked.filter((b) => b.duration === "Temporary").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Permanent</div>
          <div className="text-2xl font-bold text-rose-700 mt-2">
            {blocked.filter((b) => b.duration === "Permanent").length}
          </div>
        </div>
      </div>
    </div>
  );
}
