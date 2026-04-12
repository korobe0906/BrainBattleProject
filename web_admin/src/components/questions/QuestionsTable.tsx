import { Question } from "@/types/learningContent.types";
import { QuestionRow } from "./QuestionRow";

export function QuestionsTable({
  questions,
  selectedIds,
  onToggleSelect,
  onToggleAll,
}: {
  questions: Question[];
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
                  questions.length > 0 &&
                  questions.every((q) => selectedIds.has(q.id))
                }
                ref={(el: HTMLInputElement | null) => {
                  if (!el) return;
                  const all = questions.length > 0 &&
                    questions.every((q) => selectedIds.has(q.id));
                  const some = questions.some((q) => selectedIds.has(q.id));
                  el.indeterminate = !all && some;
                }}
                onChange={(e: React.ChangeEvent<HTMLInputElement>) => onToggleAll(e.target.checked)}
                className="w-4 h-4 rounded border-gray-300 text-pink-600 focus:ring-pink-400/40"
              />
            </th>
            <th className="px-5 py-3 font-medium">Question</th>
            <th className="px-5 py-3 font-medium">Type</th>
            <th className="px-5 py-3 font-medium">Level</th>
            <th className="px-5 py-3 font-medium">Difficulty</th>
            <th className="px-5 py-3 font-medium">Topic</th>
            <th className="px-5 py-3 font-medium">Points</th>
            <th className="px-5 py-3 font-medium">Status</th>
            <th className="px-5 py-3 font-medium">Created</th>
            <th className="px-5 py-3 font-medium text-center">Actions</th>
          </tr>
        </thead>
        <tbody>
          {questions.length === 0 ? (
            <tr>
              <td colSpan={10} className="px-5 py-12 text-center text-gray-500">
                No questions found
              </td>
            </tr>
          ) : (
            questions.map((question) => (
              <QuestionRow
                key={question.id}
                question={question}
                checked={selectedIds.has(question.id)}
                onToggle={() => onToggleSelect(question.id)}
              />
            ))
          )}
        </tbody>
      </table>
    </div>
  );
}

