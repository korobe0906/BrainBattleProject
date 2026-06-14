import { ScrollText } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { EmptyState } from '@/components/admin/EmptyState';

export default function AuditLogsPage() {
  return (
    <div className="space-y-6 pb-10">
      <PageHero
        eyebrow="System Trace"
        title="Audit Logs"
        description="Các điểm truy vết hiện có nằm trong question review logs, rank logs, reward ledger và on-chain records. Màn hình này giữ vị trí cho audit-log tổng hợp khi backend mở endpoint riêng."
        icon={ScrollText}
      />
      <SurfaceCard className="p-5">
        <EmptyState
          title="Chưa có audit API tổng quát"
          description="Backend hiện chưa expose endpoint audit log tập trung. Hãy dùng Question Bank, Ranking, Reward Ledger và Blockchain Evidence để kiểm chứng dữ liệu theo từng miền nghiệp vụ."
        />
      </SurfaceCard>
    </div>
  );
}
