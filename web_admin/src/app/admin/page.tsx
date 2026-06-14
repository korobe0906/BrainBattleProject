'use client';

import { useEffect, useMemo, useState } from 'react';
import { Activity, Coins, FileQuestion, ShieldCheck, ShoppingBag, Sword, Users, Wallet } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { MetricCard } from '@/components/admin/MetricCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { StatusBadge } from '@/components/admin/StatusBadge';
import { getAdminUsers } from '@/lib/api/admin-users';
import { adminBattleApi, unwrapItems } from '@/lib/api/admin-battle';
import type { AdminUserListItem } from '@/types/admin-auth.types';
import type { AdminBattle, BattleQuestion } from '@/types/battle-admin.types';

export default function AdminDashboardPage() {
  const [users, setUsers] = useState<AdminUserListItem[]>([]);
  const [battles, setBattles] = useState<AdminBattle[]>([]);
  const [questions, setQuestions] = useState<BattleQuestion[]>([]);
  const [shopCount, setShopCount] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    Promise.all([
      getAdminUsers().catch(() => []),
      adminBattleApi.listBattles({ page: 1, limit: 8 }).then(unwrapItems).catch(() => []),
      adminBattleApi.listQuestions({ page: 1, limit: 8 }).then(unwrapItems).catch(() => []),
      adminBattleApi.listShopItems().catch(() => []),
    ]).then(([u, b, q, s]) => {
      setUsers(u);
      setBattles(b);
      setQuestions(q);
      setShopCount(s.length);
    }).finally(() => setLoading(false));
  }, []);

  const stats = useMemo(() => ({
    users: users.length,
    wallets: users.reduce((sum, user) => sum + (user.wallet_count ?? 0), 0),
    battles: battles.length,
    finished: battles.filter((battle) => battle.status === 'FINISHED').length,
    approvedQuestions: questions.filter((q) => q.status === 'APPROVED').length,
  }), [users, battles, questions]);

  return (
    <div className="space-y-6 pb-10">
      <PageHero
        eyebrow="Production Control Center"
        title="BrainBattle Admin Console"
        description="Bảng điều khiển thật cho Auth, Battle, Question Bank, BrainPoint reward, shop item và blockchain evidence. Dữ liệu lấy trực tiếp từ backend; khi chưa có bản ghi, màn hình hiển thị trạng thái trống."
        icon={ShieldCheck}
      />

      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        <MetricCard icon={Users} label="Users" value={stats.users} hint="Auth service" />
        <MetricCard icon={Wallet} label="Linked wallets" value={stats.wallets} hint="For on-chain settlement" />
        <MetricCard icon={Sword} label="Recent battles" value={stats.battles} hint={`${stats.finished} finished`} />
        <MetricCard icon={FileQuestion} label="Approved questions" value={stats.approvedQuestions} hint={`${questions.length} loaded`} />
      </div>

      <div className="grid gap-6 xl:grid-cols-[1.15fr_0.85fr]">
        <SurfaceCard className="overflow-hidden">
          <div className="flex items-center justify-between gap-4 p-5">
            <div><h2 className="text-lg font-black">Recent battles</h2><p className="text-sm text-[var(--bb-muted)]">Realtime battle history from backend.</p></div>
            <StatusBadge value={loading ? 'PENDING' : 'ACTIVE'} />
          </div>
          {!loading && !battles.length ? <div className="p-5"><EmptyState title="Chưa có battle" /></div> : null}
          {battles.length ? <div className="bb-scrollbar overflow-x-auto"><table className="bb-table"><thead><tr><th>Room</th><th>Format</th><th>Status</th><th>Players</th></tr></thead><tbody>{battles.map((battle) => <tr key={battle.battleId}><td><p className="font-black">{battle.roomCode ?? battle.battleId.slice(0, 8)}</p><p className="text-xs text-[var(--bb-muted)]">{battle.battleId}</p></td><td><StatusBadge value={battle.format} /></td><td><StatusBadge value={battle.status} /></td><td>{battle.playerCount ?? 0}</td></tr>)}</tbody></table></div> : null}
        </SurfaceCard>

        <div className="space-y-6">
          <SurfaceCard className="p-5"><div className="flex items-center gap-3"><Coins className="h-5 w-5 text-[var(--bb-pink)]" /><h2 className="text-lg font-black">Reward / Blockchain</h2></div><p className="mt-3 text-sm leading-6 text-[var(--bb-muted)]">Admin có thể kiểm tra reward ledger theo userId và on-chain record theo battleId. Khi backend bật blockchain local/testnet, màn hình Evidence sẽ show txHash thật.</p></SurfaceCard>
          <SurfaceCard className="p-5"><div className="flex items-center gap-3"><ShoppingBag className="h-5 w-5 text-[var(--bb-purple)]" /><h2 className="text-lg font-black">Shop items</h2></div><p className="mt-3 text-3xl font-black">{shopCount}</p><p className="text-sm text-[var(--bb-muted)]">Star Protection, Double Reward, Rank Shield.</p></SurfaceCard>
          <SurfaceCard className="p-5"><div className="flex items-center gap-3"><Activity className="h-5 w-5 text-[var(--bb-cyan)]" /><h2 className="text-lg font-black">Question readiness</h2></div><p className="mt-3 text-sm text-[var(--bb-muted)]">Cần đủ 10 câu approved cho 1v1 và 10 câu từng role cho 3v3.</p></SurfaceCard>
        </div>
      </div>
    </div>
  );
}
