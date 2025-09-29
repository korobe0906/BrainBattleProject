import { LucideIcon } from 'lucide-react';

interface StatCardProps {
  icon: LucideIcon;
  label: string;
  value: string;
  change: string;
  changeType: 'increase' | 'decrease';
}

export default function StatCard({
  icon: Icon,
  label,
  value,
  change,
  changeType
}: StatCardProps) {
  const isIncrease = changeType === 'increase';

  return (
    <div
      className="p-4 rounded-xl space-y-2
                 bg-white border border-gray-200 shadow-sm
                 transition hover:shadow-md"
    >
      {/* Icon + Label */}
      <div className="flex items-center gap-2 text-pink-600">
        <Icon className="w-5 h-5" />
        <span className="font-medium text-sm">{label}</span>
      </div>

      {/* Value */}
      <div className="text-3xl font-bold text-gray-900">{value}</div>

      {/* Change */}
      <div
        className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium
          ${isIncrease
            ? 'bg-green-100 text-green-700'
            : 'bg-red-100 text-red-600'
          }`}
      >
        {isIncrease ? '▲' : '▼'} {change}
      </div>
    </div>
  );
}
