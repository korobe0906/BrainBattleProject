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
                 bg-gradient-to-b from-[#1A1D24] to-[#22252C]
                 border border-white/5 shadow-[0_4px_20px_rgba(0,0,0,0.25)]
                 transition hover:shadow-[0_6px_24px_rgba(0,0,0,0.35)]"
    >
      {/* Icon + Label */}
      <div className="flex items-center gap-2 text-[#FFD84D]">
        <Icon className="w-5 h-5" />
        <span className="font-medium text-sm">{label}</span>
      </div>

      {/* Value */}
      <div className="text-3xl font-bold text-white">{value}</div>

      {/* Change */}
      <div
        className={`inline-flex items-center gap-1 px-2 py-0.5 rounded-full text-xs font-medium
          ${isIncrease
            ? 'bg-green-500/10 text-green-400'
            : 'bg-red-500/10 text-red-400'
          }`}
      >
        {isIncrease ? '▲' : '▼'} {change}
      </div>
    </div>
  );
}
