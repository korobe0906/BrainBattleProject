"use client";

import { useEffect, useMemo, useState } from "react";
import { Search, Plus, Edit2, Trash2, Filter } from "lucide-react";
import { MetadataTag, TAG_CATEGORIES } from "@/types/learningContent.types";
import { mockTags } from "@/mock/learningContent.mock";

const ITEMS_PER_PAGE = 15;

export default function TagsPage() {
  const [tags, setTags] = useState<MetadataTag[]>([]);
  const [q, setQ] = useState("");
  const [category, setCategory] = useState("All");
  const [status, setStatus] = useState("All");
  const [currentPage, setCurrentPage] = useState(1);
  const [editingTag, setEditingTag] = useState<MetadataTag | null>(null);
  const [showForm, setShowForm] = useState(false);

  useEffect(() => {
    setTags(mockTags);
  }, []);

  const filtered = useMemo(() => {
    return tags.filter((t) => {
      const matchesQ =
        q === "" ||
        t.name.toLowerCase().includes(q.toLowerCase()) ||
        t.tagCode.toLowerCase().includes(q.toLowerCase());

      const matchesCategory =
        category === "All" || t.category === category;

      const matchesStatus =
        status === "All" || t.status === status;

      return matchesQ && matchesCategory && matchesStatus;
    });
  }, [tags, q, category, status]);

  const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
  const paginatedTags = filtered.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  const categoryColor: Record<string, string> = {
    Topic: "bg-blue-100 text-blue-700",
    Grammar: "bg-purple-100 text-purple-700",
    Vocab: "bg-green-100 text-green-700",
    Skill: "bg-orange-100 text-orange-700",
    Other: "bg-gray-100 text-gray-700",
  };

  const handleDelete = (id: string) => {
    if (confirm("Are you sure you want to delete this tag?")) {
      setTags((prev) => prev.filter((t) => t.id !== id));
    }
  };

  const handleSaveTag = () => {
    if (editingTag) {
      setTags((prev) =>
        prev.map((t) => (t.id === editingTag.id ? editingTag : t))
      );
    }
    setEditingTag(null);
    setShowForm(false);
  };

  return (
    <div className="space-y-6">
      {/* Create Tag Button */}
      

      {/* Search & Filters */}
      <div className="space-y-3">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
          <input
            type="text"
            placeholder="Search tags by name or code..."
            value={q}
            onChange={(e: React.ChangeEvent<HTMLInputElement>) => setQ(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-pink-400/40"
          />
        </div>

        <div className="flex flex-wrap gap-2">
          <select
            value={category}
            onChange={(e: React.ChangeEvent<HTMLSelectElement>) => setCategory(e.target.value)}
            className="px-3 py-2 rounded-xl border border-gray-200 bg-white text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-pink-400/40"
          >
            <option value="All">All categories</option>
            {TAG_CATEGORIES.map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
          </select>

          <select
            value={status}
            onChange={(e: React.ChangeEvent<HTMLSelectElement>) => setStatus(e.target.value)}
            className="px-3 py-2 rounded-xl border border-gray-200 bg-white text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-pink-400/40"
          >
            <option value="All">All statuses</option>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
          </select>
        </div>
      </div>

      {/* Tags Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {paginatedTags.map((tag) => (
          <div
            key={tag.id}
            className="rounded-xl bg-white border border-gray-200 p-4 hover:shadow-md transition"
          >
            <div className="flex items-start justify-between mb-3">
              <div className="flex-1">
                <div className="flex items-center gap-2 mb-1">
                  <h3 className="font-semibold text-gray-900">{tag.name}</h3>
                  <span
                    className="inline-block w-3 h-3 rounded-full"
                    style={{ backgroundColor: tag.color }}
                  />
                </div>
                <p className="text-xs text-gray-500">{tag.tagCode}</p>
              </div>
              <span
                className={`px-2 py-1 rounded text-xs font-medium ${
                  categoryColor[tag.category] || categoryColor.Other
                }`}
              >
                {tag.category}
              </span>
            </div>

            {tag.description && (
              <p className="text-xs text-gray-600 mb-3 line-clamp-2">
                {tag.description}
              </p>
            )}

            <div className="flex items-center justify-between mb-3 text-xs text-gray-600">
              <span>Used in: {tag.usageCount}</span>
              <span
                className={`px-2 py-1 rounded ${
                  tag.status === "Active"
                    ? "bg-emerald-100 text-emerald-700"
                    : "bg-amber-100 text-amber-700"
                }`}
              >
                {tag.status}
              </span>
            </div>

            <div className="flex items-center gap-2">
              <button
                type={"button" as const}
                onClick={() => {
                  setEditingTag(tag);
                  setShowForm(true);
                }}
                className="flex-1 inline-flex items-center justify-center gap-1 px-3 py-2 rounded-lg border border-gray-200 text-gray-700 text-sm hover:bg-gray-50 transition"
              >
                <Edit2 className="w-3 h-3" />
                Edit
              </button>
              <button
                type={"button" as const}
                onClick={() => handleDelete(tag.id)}
                className="px-3 py-2 rounded-lg border border-rose-200 text-rose-600 text-sm hover:bg-rose-50 transition"
              >
                <Trash2 className="w-4 h-4" />
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filtered.length)} of {filtered.length} tags
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
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Total Tags</div>
          <div className="text-2xl font-bold text-gray-900 mt-2">{tags.length}</div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Active</div>
          <div className="text-2xl font-bold text-emerald-600 mt-2">
            {tags.filter((t) => t.status === "Active").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Most Used</div>
          <div className="text-2xl font-bold text-pink-600 mt-2">
            {tags.reduce((max, t) => (t.usageCount > max ? t.usageCount : max), 0)}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Total Usage</div>
          <div className="text-2xl font-bold text-blue-600 mt-2">
            {tags.reduce((sum, t) => sum + t.usageCount, 0)}
          </div>
        </div>
      </div>
    </div>
  );
}
