"use client";

import { useEffect, useMemo, useState } from "react";
import { LessonsHeader } from "@/components/lessons/LessonsHeader";
import { LessonsToolbar } from "@/components/lessons/LessonsToolbar";
import { LessonsTable } from "@/components/lessons/LessonsTable";
import { Lesson } from "@/types/learningContent.types";
import { mockLessons } from "@/mock/learningContent.mock";

const ITEMS_PER_PAGE = 10;

export default function LessonsPage() {
  const [lessons, setLessons] = useState<Lesson[]>([]);
  const [q, setQ] = useState("");
  const [status, setStatus] = useState("All");
  const [level, setLevel] = useState("All");
  const [language, setLanguage] = useState("All");
  const [skillFocus, setSkillFocus] = useState("All");
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    setLessons(mockLessons);
  }, []);
  useEffect(() => {
    setLessons(mockLessons);
  }, []);

  const filtered = useMemo(() => {
    return lessons.filter((l) => {
      const matchesQ =
        q === "" ||
        l.title.toLowerCase().includes(q.toLowerCase()) ||
        l.lessonCode.toLowerCase().includes(q.toLowerCase());

      const matchesStatus = status === "All" || l.status === status;
      const matchesLevel = level === "All" || l.level === level;
      const matchesLanguage = language === "All" || l.language === language;
      const matchesSkill = skillFocus === "All" || l.skillFocus === skillFocus;

      return (
        matchesQ &&
        matchesStatus &&
        matchesLevel &&
        matchesLanguage &&
        matchesSkill
      );
    });
  }, [lessons, q, status, level, language, skillFocus]);

  const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
  const paginatedLessons = filtered.slice(
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
      setSelectedIds(new Set(paginatedLessons.map((l) => l.id)));
    } else {
      setSelectedIds(new Set());
    }
  };

  return (
    <div className="space-y-6">
      {/* Toolbar */}
      <LessonsHeader />

      {/* Search & Filters */}
      <LessonsToolbar
        q={q}
        onQChange={setQ}
        status={status}
        onStatusChange={setStatus}
        level={level}
        onLevelChange={setLevel}
        language={language}
        onLanguageChange={setLanguage}
        skillFocus={skillFocus}
        onSkillFocusChange={setSkillFocus}
      />

      {/* Table */}
      <LessonsTable
        lessons={paginatedLessons}
        selectedIds={selectedIds}
        onToggleSelect={handleToggleSelect}
        onToggleAll={handleToggleAll}
      />

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filtered.length)} of {filtered.length} lessons
        </div>
        <div className="flex gap-2">
          <button
            type="button"
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
                type="button"
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
            type="button"
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
          <div className="text-sm text-gray-600">Total Lessons</div>
          <div className="text-2xl font-bold text-gray-900 mt-2">{lessons.length}</div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Published</div>
          <div className="text-2xl font-bold text-emerald-600 mt-2">
            {lessons.filter((l) => l.status === "Published").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Total Enrollments</div>
          <div className="text-2xl font-bold text-pink-600 mt-2">
            {lessons.reduce((acc, l) => acc + l.metrics.enrollments, 0)}
          </div>
        </div>
      </div>
    </div>
  );
}

