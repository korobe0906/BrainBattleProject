"use client";

import { useEffect, useMemo, useState } from "react";
import { TopicsHeader } from "@/components/clans/TopicsHeader";
import { TopicsToolbar } from "@/components/clans/TopicsToolbar";
import { TopicsTable } from "@/components/clans/TopicsTable";
import { Topic, TopicCategory, TopicStatus } from "@/types/clanGuild.types";
import { mockTopics } from "@/mock/clanGuild/topics.mock";

const ITEMS_PER_PAGE = 20;

export default function SearchTopicsPage() {
  const [topics, setTopics] = useState<Topic[]>([]);
  const [q, setQ] = useState("");
  const [category, setCategory] = useState<TopicCategory | "All">("All");
  const [status, setStatus] = useState<TopicStatus | "All">("All");
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    setTopics(mockTopics);
  }, []);

  const filtered = useMemo(() => {
    return topics.filter((topic) => {
      const matchesQ =
        q === "" ||
        topic.name.toLowerCase().includes(q.toLowerCase()) ||
        (topic.synonyms && topic.synonyms.some((s) => s.toLowerCase().includes(q.toLowerCase())));

      const matchesCategory = category === "All" || topic.category === category;
      const matchesStatus = status === "All" || topic.status === status;

      return matchesQ && matchesCategory && matchesStatus;
    });
  }, [topics, q, category, status]);

  const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
  const paginatedTopics = filtered.slice(
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
      setSelectedIds(new Set(paginatedTopics.map((t) => t.id)));
    } else {
      setSelectedIds(new Set());
    }
  };

  return (
    <div className="space-y-6">
      <TopicsHeader />

      <TopicsToolbar
        q={q}
        onQChange={setQ}
        category={category}
        onCategoryChange={setCategory}
        status={status}
        onStatusChange={setStatus}
      />

      <TopicsTable
        topics={paginatedTopics}
        selectedIds={selectedIds}
        onToggleSelect={handleToggleSelect}
        onToggleAll={handleToggleAll}
      />

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filtered.length)} of {filtered.length} topics
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
            {Array.from({ length: Math.min(5, totalPages) }).map((_, i) => {
              const pageNum = i + 1;
              return (
                <button
                  key={pageNum}
                  type={"button" as const}
                  onClick={() => setCurrentPage(pageNum)}
                  className={`px-2 py-1 rounded text-sm ${
                    currentPage === pageNum
                      ? "bg-pink-600 text-white"
                      : "border border-gray-200 text-gray-700 hover:bg-gray-50"
                  }`}
                >
                  {pageNum}
                </button>
              );
            })}
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
          <div className="text-sm text-gray-600">Total Topics</div>
          <div className="text-2xl font-bold text-gray-900 mt-2">{topics.length}</div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Active Topics</div>
          <div className="text-2xl font-bold text-emerald-600 mt-2">
            {topics.filter((t) => t.status === "Active").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Total Usage</div>
          <div className="text-2xl font-bold text-pink-600 mt-2">
            {topics.reduce((sum, t) => sum + t.usageCount, 0)}
          </div>
        </div>
      </div>
    </div>
  );
}
