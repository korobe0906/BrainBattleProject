'use client';

import { useState } from 'react';
import { Crown, RefreshCw } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { SearchBox } from '@/components/admin/Toolbar';
import { ActionButton } from '@/components/admin/ActionButton';
import { JsonPanel } from '@/components/admin/JsonPanel';
import { adminBattleApi } from '@/lib/api/admin-battle';

export default function RankingPage() {
  const [userId, setUserId] = useState('');
  const [rank, setRank] = useState<unknown>(null);
  const [logs, setLogs] = useState<unknown>(null);
  async function load() {
    if (!userId.trim()) return;
    const [r, l] = await Promise.all([adminBattleApi.getRank(userId.trim()), adminBattleApi.getRankLogs(userId.trim())]);
    setRank(r);
    setLogs(l);
  }
  return <div className="space-y-6 pb-10"><PageHero eyebrow="Season Rank Snapshot" title="Ranking" description="Xem rank profile và lịch sử cộng/trừ sao thật theo userId, phục vụ kiểm chứng sau battle." icon={Crown} />
    <SurfaceCard className="p-5"><div className="flex flex-col gap-3 xl:flex-row"><SearchBox value={userId} onChange={setUserId} placeholder="Nhập userId..." /><ActionButton onClick={load}><RefreshCw className="h-4 w-4" />Load rank</ActionButton></div></SurfaceCard>
    <div className="grid gap-6 xl:grid-cols-2"><SurfaceCard className="p-5"><h2 className="text-lg font-black">Rank profile</h2><div className="mt-4">{rank ? <JsonPanel value={rank} /> : <EmptyState title="Chưa có rank profile" />}</div></SurfaceCard><SurfaceCard className="p-5"><h2 className="text-lg font-black">Rank logs</h2><div className="mt-4">{logs ? <JsonPanel value={logs} /> : <EmptyState title="Chưa có rank logs" />}</div></SurfaceCard></div>
  </div>;
}
