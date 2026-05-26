"use client";

import { useEffect, useMemo, useRef, useState } from "react";
import { Search, Filter, ChevronDown } from "lucide-react";
import {
  LESSON_LEVELS,
  LANGUAGES,
  SKILL_FOCUSES,
  LessonLevel,
  LessonSkillFocus,
  LessonStatus,
} from "@/types/learningContent.types";

type FilterOption = {
  label: string;
  value: string;
};

const STATUS_OPTIONS: FilterOption[] = [
  { label: "All statuses", value: "All" },
  { label: "Published", value: "Published" },
  { label: "Draft", value: "Draft" },
  { label: "Archived", value: "Archived" },
];

const LEVEL_OPTIONS: FilterOption[] = [
  { label: "All levels", value: "All" },
  ...LESSON_LEVELS.map((l) => ({ label: l, value: l })),
];

const LANGUAGE_OPTIONS: FilterOption[] = [
  { label: "All languages", value: "All" },
  ...LANGUAGES.map((l) => ({ label: l.toUpperCase(), value: l })),
];

const SKILL_OPTIONS: FilterOption[] = [
  { label: "All skills", value: "All" },
  ...SKILL_FOCUSES.map((s) => ({ label: s, value: s })),
];

function FilterDropdown({
  icon: Icon,
  label,
  options,
  value,
  onChange,
}: {
  icon: React.ReactNode;
  label: string;
  options: FilterOption[];
  value: string;
  onChange: (v: string) => void;
}) {
  const [open, setOpen] = useState(false);
  const wrapRef = useRef<HTMLDivElement | null>(null);

  const current = options.find((o) => o.value === value) ?? options[0];

  useEffect(() => {
    const onClickOutside = (e: MouseEvent) => {
      if (wrapRef.current && !wrapRef.current.contains(e.target as Node)) {
        setOpen(false);
      }
    };
    const onEsc = (e: KeyboardEvent) => e.key === "Escape" && setOpen(false);

    document.addEventListener("mousedown", onClickOutside);
    document.addEventListener("keydown", onEsc);
    return () => {
      document.removeEventListener("mousedown", onClickOutside);
      document.removeEventListener("keydown", onEsc);
    };
  }, []);

  return (
    <div ref={wrapRef} className="relative">
      <button
        type={"button" as const}
        onClick={() => setOpen((v) => !v)}
        className={[
          "inline-flex items-center gap-2 px-3 py-2 rounded-xl text-sm font-medium",
          "bg-white border border-gray-200 shadow-sm",
          "hover:border-pink-300 hover:shadow transition",
          "focus:outline-none focus:ring-2 focus:ring-pink-400/40",
        ].join(" ")}
      >
        {Icon}
        <span className="text-gray-800 hidden sm:inline">{current.label}</span>
        <ChevronDown className="w-4 h-4 text-gray-400" />
      </button>

      {open && (
        <div className="absolute right-0 mt-2 w-44 z-20 overflow-hidden rounded-2xl bg-white border border-gray-200 shadow-lg animate-in fade-in zoom-in-95">
          {options.map((opt) => {
            const active = opt.value === value;
            return (
              <button
                key={opt.value}
                type={"button" as const}
                onClick={() => {
                  onChange(opt.value);
                  setOpen(false);
                }}
                className={`w-full text-left px-4 py-2 text-sm transition ${
                  active
                    ? "bg-pink-50 text-pink-700 font-medium"
                    : "text-gray-700 hover:bg-gray-50"
                }`}
              >
                {opt.label}
              </button>
            );
          })}
        </div>
      )}
    </div>
  );
}

export function LessonsToolbar({
  q,
  onQChange,
  status,
  onStatusChange,
  level,
  onLevelChange,
  language,
  onLanguageChange,
  skillFocus,
  onSkillFocusChange,
}: {
  q: string;
  onQChange: (v: string) => void;
  status: string;
  onStatusChange: (v: string) => void;
  level: string;
  onLevelChange: (v: string) => void;
  language: string;
  onLanguageChange: (v: string) => void;
  skillFocus: string;
  onSkillFocusChange: (v: string) => void;
}) {
  return (
    <div className="space-y-3">
      {/* Search Bar */}
      <div className="relative">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
        <input
          type="text"
          placeholder="Search lessons by title, code..."
          value={q}
          onChange={(e: React.ChangeEvent<HTMLInputElement>) => onQChange(e.target.value)}
          className="w-full pl-10 pr-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-pink-400/40 focus:border-transparent transition"
        />
      </div>

      {/* Filters */}
      <div className="flex flex-wrap gap-2">
        <FilterDropdown
          icon={<Filter className="w-4 h-4 text-gray-400" />}
          label="Status"
          options={STATUS_OPTIONS}
          value={status}
          onChange={onStatusChange}
        />

        <FilterDropdown
          icon={<Filter className="w-4 h-4 text-gray-400" />}
          label="Level"
          options={LEVEL_OPTIONS}
          value={level}
          onChange={onLevelChange}
        />

        <FilterDropdown
          icon={<Filter className="w-4 h-4 text-gray-400" />}
          label="Language"
          options={LANGUAGE_OPTIONS}
          value={language}
          onChange={onLanguageChange}
        />

        <FilterDropdown
          icon={<Filter className="w-4 h-4 text-gray-400" />}
          label="Skill Focus"
          options={SKILL_OPTIONS}
          value={skillFocus}
          onChange={onSkillFocusChange}
        />
      </div>
    </div>
  );
}
