import { Lesson } from "@/types/learningContent.types";
import { LessonRow } from "./LessonRow";

export function LessonsTable({
  lessons,
  selectedIds,
  onToggleSelect,
  onToggleAll,
}: {
  lessons: Lesson[];
  selectedIds: Set<string>;
  onToggleSelect: (id: string) => void;
  onToggleAll: (checked: boolean) => void;
}) {
  return (
    <div className="overflow-x-auto rounded-2xl bg-white border border-gray-200 shadow-sm">
      <table className="min-w-full">
        <thead>
          <tr className="text-left text-gray-600 text-sm border-b border-gray-200">
            <th className="px-3 py-3 w-10">
              <input
                type="checkbox"
                checked={
                  lessons.length > 0 &&
                  lessons.every((l) => selectedIds.has(l.id))
                }
                ref={(el: HTMLInputElement | null) => {
                  if (!el) return;
                  const all = lessons.length > 0 &&
                    lessons.every((l) => selectedIds.has(l.id));
                  const some = lessons.some((l) => selectedIds.has(l.id));
                  el.indeterminate = !all && some;
                }}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => onToggleAll(e.target.checked)}
                className="w-4 h-4 rounded border-gray-300 text-pink-600 focus:ring-pink-400/40"
              />
            </th>
            <th className="px-5 py-3 font-medium">Lesson</th>
            <th className="px-5 py-3 font-medium">Language</th>
            <th className="px-5 py-3 font-medium">Level</th>
            <th className="px-5 py-3 font-medium">Skill Focus</th>
            <th className="px-5 py-3 font-medium">Duration</th>
            <th className="px-5 py-3 font-medium">Units</th>
            <th className="px-5 py-3 font-medium">Status</th>
            <th className="px-5 py-3 font-medium">Created at</th>
            <th className="px-5 py-3 font-medium text-center">Actions</th>
          </tr>
        </thead>
        <tbody>
          {lessons.map((lesson) => (
            <LessonRow
              key={lesson.id}
              lesson={lesson}
              checked={selectedIds.has(lesson.id)}
              onToggle={() => onToggleSelect(lesson.id)}
            />
          ))}
        </tbody>
      </table>
    </div>
  );
}
