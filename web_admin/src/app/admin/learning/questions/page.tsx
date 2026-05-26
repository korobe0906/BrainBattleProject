"use client";

import { useEffect, useMemo, useState } from "react";
import { QuestionsHeader } from "@/components/questions/QuestionsHeader";
import { QuestionsToolbar } from "@/components/questions/QuestionsToolbar";
import { QuestionsTable } from "@/components/questions/QuestionsTable";
import { Question } from "@/types/learningContent.types";
import { mockQuestions } from "@/mock/learningContent.mock";

const ITEMS_PER_PAGE = 10;

export default function QuestionsPage() {
  const [questions, setQuestions] = useState<Question[]>([]);
  const [q, setQ] = useState("");
  const [status, setStatus] = useState("All");
  const [type, setType] = useState("All");
  const [difficulty, setDifficulty] = useState("All");
  const [level, setLevel] = useState("All");
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    setQuestions(mockQuestions);
  }, []);

  const filtered = useMemo(() => {
    return questions.filter((question) => {
      const matchesQ =
        q === "" ||
        question.questionText.toLowerCase().includes(q.toLowerCase()) ||
        question.questionCode.toLowerCase().includes(q.toLowerCase());

      const matchesStatus = status === "All" || question.status === status;
      const matchesType = type === "All" || question.type === type;
      const matchesDifficulty = difficulty === "All" || question.difficulty === difficulty;
      const matchesLevel = level === "All" || question.level === level;

      return (
        matchesQ &&
        matchesStatus &&
        matchesType &&
        matchesDifficulty &&
        matchesLevel
      );
    });
  }, [questions, q, status, type, difficulty, level]);

  const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
  const paginatedQuestions = filtered.slice(
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
      setSelectedIds(new Set(paginatedQuestions.map((q) => q.id)));
    } else {
      setSelectedIds(new Set());
    }
  };

  return (
    <div className="space-y-6">
      

      {/* Search & Filters */}
      <QuestionsToolbar
        q={q}
        onQChange={setQ}
        status={status}
        onStatusChange={setStatus}
        type={type}
        onTypeChange={setType}
        difficulty={difficulty}
        onDifficultyChange={setDifficulty}
        level={level}
        onLevelChange={setLevel}
      />

      {/* Table */}
      <QuestionsTable
        questions={paginatedQuestions}
        selectedIds={selectedIds}
        onToggleSelect={handleToggleSelect}
        onToggleAll={handleToggleAll}
      />

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filtered.length)} of {filtered.length} questions
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
          <div className="text-sm text-gray-600">Total Questions</div>
          <div className="text-2xl font-bold text-gray-900 mt-2">{questions.length}</div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Active</div>
          <div className="text-2xl font-bold text-emerald-600 mt-2">
            {questions.filter((q) => q.status === "Active").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Avg Correct Rate</div>
          <div className="text-2xl font-bold text-pink-600 mt-2">
            {(
              questions.reduce((acc, q) => acc + q.usageStats.correctRate, 0) /
              Math.max(1, questions.length)
            ).toFixed(2)}
          </div>
        </div>
      </div>
    </div>
  );
}
