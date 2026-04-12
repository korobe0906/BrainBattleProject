import { Question, QuestionStatus } from "@/types/learningContent.types";

export function QuestionStatusBadge({ status }: { status: QuestionStatus }) {
  const map: Record<QuestionStatus, { label: string; cls: string }> = {
    Active: {
      label: "Active",
      cls: "bg-emerald-100 text-emerald-700 ring-1 ring-emerald-300",
    },
    Inactive: {
      label: "Inactive",
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

export function QuestionRow({
  question,
  checked,
  onToggle,
}: {
  question: Question;
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

      <td className="px-5 py-3 min-w-0">
        <div className="space-y-0.5">
          <div className="font-medium text-gray-900 truncate text-sm">
            {question.questionText.substring(0, 50)}...
          </div>
          <div className="text-xs text-gray-500">{question.questionCode}</div>
        </div>
      </td>

      <td className="px-5 py-3 text-sm text-gray-600">{question.type}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{question.level}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{question.difficulty}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{question.topic}</td>
      <td className="px-5 py-3 text-sm text-gray-600">{question.points} pts</td>

      <td className="px-5 py-3">
        <QuestionStatusBadge status={question.status} />
      </td>

      <td className="px-5 py-3 text-sm text-gray-600">{fmtDate(question.createdAt)}</td>

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

