"use client";

import { useEffect, useMemo, useState } from "react";
import { ClansHeader } from "@/components/clans/ClansHeader";
import { ClansToolbar } from "@/components/clans/ClansToolbar";
import { ClansTable } from "@/components/clans/ClansTable";
import { Clan, ClanStatus } from "@/types/clanGuild.types";
import { mockClans } from "@/mock/clanGuild/clans.mock";

const ITEMS_PER_PAGE = 20;

export default function ClansPage() {
  const [clans, setClans] = useState<Clan[]>([]);
  const [q, setQ] = useState("");
  const [status, setStatus] = useState<ClanStatus | "All">("All");
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    setClans(mockClans);
  }, []);

  const filtered = useMemo(() => {
    return clans.filter((clan) => {
      const matchesQ =
        q === "" ||
        clan.name.toLowerCase().includes(q.toLowerCase()) ||
        clan.clanCode.toLowerCase().includes(q.toLowerCase()) ||
        clan.leaderName.toLowerCase().includes(q.toLowerCase());

      const matchesStatus = status === "All" || clan.status === status;

      return matchesQ && matchesStatus;
    });
  }, [clans, q, status]);

  const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
  const paginatedClans = filtered.slice(
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
      setSelectedIds(new Set(paginatedClans.map((c) => c.id)));
    } else {
      setSelectedIds(new Set());
    }
  };

  return (
    <div className="space-y-6">
      {/* Toolbar */}
      <ClansHeader />

      {/* Search & Filters */}
      <ClansToolbar
        q={q}
        onQChange={setQ}
        status={status}
        onStatusChange={setStatus}
      />

      {/* Table */}
      <ClansTable
        clans={paginatedClans}
        selectedIds={selectedIds}
        onToggleSelect={handleToggleSelect}
        onToggleAll={handleToggleAll}
      />

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filtered.length)} of {filtered.length} clans
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
          <div className="text-sm text-gray-600">Total Clans</div>
          <div className="text-2xl font-bold text-gray-900 mt-2">{clans.length}</div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Active Clans</div>
          <div className="text-2xl font-bold text-emerald-600 mt-2">
            {clans.filter((c) => c.status === "Active").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Total Members</div>
          <div className="text-2xl font-bold text-pink-600 mt-2">
            {clans.reduce((sum, c) => sum + c.membersCount, 0)}
          </div>
        </div>
      </div>
    </div>
  );
}
