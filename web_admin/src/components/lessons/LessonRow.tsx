"use client";
import { Lesson, LessonStatus } from "@/types/learningContent.types";

export function LessonStatusBadge({ status }: { status: LessonStatus }) {
  const map: Record<LessonStatus, { label: string; cls: string }> = {
    Published: {
      label: "Published",
      cls: "bg-emerald-100 text-emerald-700 ring-1 ring-emerald-300",
    },
    Draft: {
      label: "Draft",
      cls: "bg-amber-100 text-amber-700 ring-1 ring-amber-300",
    },
    Archived: {
      label: "Archived",
      cls: "bg-gray-100 text-gray-700 ring-1 ring-gray-300",
    },
  };

  return (
    <span
      className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${map[status].cls}`}
    >
      {map[status].label}
    </span>
  );
}

const fmtDate = (iso: string) => {
  const d = new Date(iso);
  return d.toLocaleDateString("en-US", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

export function LessonRow({
  lesson,
  checked,
  onToggle,
}: {
  lesson: Lesson;
  checked: boolean;
  onToggle: () => void;
}) {
  return (
    <tr className="border-b border-gray-100 hover:bg-gray-50 transition">
      <td className="px-3 py-3 w-10 align-top">
        <input
          type="checkbox"
          checked={checked}
          onChange={onToggle}
          className="w-4 h-4 rounded border-gray-300 text-pink-600 focus:ring-pink-400/40"
        />
      </td>

      <td className="px-5 py-3">
        <div className="flex items-start gap-3">
          <div className="w-12 h-12 rounded-lg overflow-hidden bg-gradient-to-r from-pink-400 to-purple-400 flex-shrink-0">
            {lesson.thumbnailUrl ? (
              <img
                src={lesson.thumbnailUrl}
                alt={lesson.title}
                className="w-full h-full object-cover"
              />
            ) : (
              <div className="w-full h-full flex items-center justify-center text-white text-xs font-bold">
                {lesson.lessonCode.substring(0, 3)}
              </div>
            )}
          </div>

          <div className="space-y-0.5 min-w-0">
            <div className="font-medium text-gray-900 truncate">{lesson.title}</div>
            <div className="text-xs text-gray-500">{lesson.lessonCode}</div>
          </div>
        </div>
      </td>

      <td className="px-5 py-3 text-sm text-gray-600">{lesson.language.toUpperCase()}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{lesson.level}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{lesson.skillFocus}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{lesson.durationMinutes} min</td>
      <td className="px-5 py-3 text-sm text-gray-600">{lesson.totalUnits}</td>

      <td className="px-5 py-3">
        <LessonStatusBadge status={lesson.status} />
      </td>

      <td className="px-5 py-3 text-sm text-gray-600">{fmtDate(lesson.createdAt)}</td>

      <td className="px-5 py-3 text-sm text-center">
        <div className="flex items-center justify-center gap-2">
          <button
            type={"button" as const}
            className="text-pink-600 hover:text-pink-700 text-sm font-medium"
          >
            View
          </button>
          <button
            type={"button" as const}
            className="text-blue-600 hover:text-blue-700 text-sm font-medium"
          >
            Edit
          </button>
        </div>
      </td>
    </tr>
  );
}
