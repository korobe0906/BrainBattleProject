'use client';

import { useEffect, useState } from 'react';
import { Activity, ClipboardCheck, RefreshCw, ShieldCheck, Sword, Link2, FileJson } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { MetricCard } from '@/components/admin/MetricCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { StatusBadge } from '@/components/admin/StatusBadge';
import { SearchBox, SelectFilter } from '@/components/admin/Toolbar';
import { ActionButton } from '@/components/admin/ActionButton';
import { JsonPanel } from '@/components/admin/JsonPanel';
import { adminBattleApi, unwrapItems } from '@/lib/api/admin-battle';
import type { AdminBattle } from '@/types/battle-admin.types';

const statuses = ['All', 'CREATED', 'RUNNING', 'FINISHED', 'CANCELLED'];
const formats = ['All', 'DUEL_1V1', 'TEAM_3V3'];

export default function BattlesPage() {
  const [items, setItems] = useState<AdminBattle[]>([]);
  const [selected, setSelected] = useState<AdminBattle | null>(null);
  const [detail, setDetail] = useState<unknown>(null);
  const [q, setQ] = useState('');
  const [status, setStatus] = useState('All');
  const [format, setFormat] = useState('All');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  async function reload() {
    setLoading(true);
    setError('');
    try {
      const data = await adminBattleApi.listBattles({
        status: status === 'All' ? undefined : status,
        format: format === 'All' ? undefined : format,
        userId: q || undefined,
        page: 1,
        limit: 50,
      });
      setItems(unwrapItems(data));
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Cannot load battles');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => { reload(); }, []);

  async function open(battle: AdminBattle) {
    setSelected(battle);
    setDetail(await adminBattleApi.getBattle(battle.battleId));
  }

  async function recordOnchain(battle: AdminBattle) {
    setSelected(battle);
    setDetail(await adminBattleApi.recordOnchain(battle.battleId));
  }

  async function openSettlementPayload(battle: AdminBattle) {
    setSelected(battle);
    setDetail(await adminBattleApi.getSettlementPayload(battle.battleId));
  }

  async function openOnchainProof(battle: AdminBattle) {
    setSelected(battle);
    setDetail(await adminBattleApi.getOnchainRecord(battle.battleId));
  }

  const finished = items.filter((item) => item.status === 'FINISHED').length;

  return (
    <div className="space-y-6 pb-10">
      <PageHero eyebrow="Realtime Competitive Learning" title="Battle Operations" description="Theo dõi battle 1v1/3v3 thật, trạng thái trận, scoreboard, submission, result và thao tác ghi nhận on-chain khi cần." icon={Sword} />
      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        <MetricCard icon={Sword} label="Battles" value={items.length} />
        <MetricCard icon={ClipboardCheck} label="Finished" value={finished} />
        <MetricCard icon={Activity} label="Submissions" value={items.reduce((s, i) => s + (i.submissionCount ?? 0), 0)} />
        <MetricCard icon={ShieldCheck} label="Ranked" value={items.filter((i) => i.isRanked).length} />
      </div>
      <SurfaceCard className="p-5"><div className="flex flex-col gap-3 xl:flex-row"><SearchBox value={q} onChange={setQ} placeholder="Filter by userId..." /><SelectFilter value={status} onChange={setStatus} options={statuses} /><SelectFilter value={format} onChange={setFormat} options={formats} /><ActionButton variant="secondary" onClick={reload}><RefreshCw className="h-4 w-4" />Load</ActionButton></div></SurfaceCard>
      <div className="grid gap-6 xl:grid-cols-[1.5fr_1fr]">
        <SurfaceCard className="overflow-hidden">
          {error ? <div className="p-5 text-sm font-bold text-[var(--bb-red)]">{error}</div> : null}
          {!loading && !items.length ? <div className="p-5"><EmptyState title="Chưa có battle" /></div> : null}
          {items.length ? <div className="bb-scrollbar overflow-x-auto"><table className="bb-table"><thead><tr><th>Battle</th><th>Format</th><th>Status</th><th>Players</th><th>Timeline</th><th>Actions</th></tr></thead><tbody>{items.map((battle) => <tr key={battle.battleId}><td><p className="font-black">{battle.roomCode ?? battle.battleId.slice(0, 8)}</p><p className="text-xs text-[var(--bb-muted)]">{battle.battleId}</p></td><td><StatusBadge value={battle.format} /><p className="mt-2 text-xs text-[var(--bb-muted)]">{battle.skill}</p></td><td><StatusBadge value={battle.status} /></td><td><p className="font-black">{battle.playerCount ?? 0}</p><p className="text-xs text-[var(--bb-muted)]">{battle.submissionCount ?? 0} answers</p></td><td><p className="text-xs text-[var(--bb-muted)]">Start: {battle.startedAt ? new Date(battle.startedAt).toLocaleString() : '-'}</p><p className="text-xs text-[var(--bb-muted)]">Finish: {battle.finishedAt ? new Date(battle.finishedAt).toLocaleString() : '-'}</p></td><td><div className="flex flex-wrap gap-2"><ActionButton variant="secondary" onClick={() => open(battle)}>Inspect</ActionButton>{battle.status === 'FINISHED' ? <><ActionButton variant="secondary" onClick={() => openSettlementPayload(battle)}><FileJson className="h-4 w-4" />Payload</ActionButton><ActionButton variant="secondary" onClick={() => openOnchainProof(battle)}><Link2 className="h-4 w-4" />Proof</ActionButton><ActionButton onClick={() => recordOnchain(battle)}>Record chain</ActionButton></> : null}</div></td></tr>)}</tbody></table></div> : null}
        </SurfaceCard>
        <SurfaceCard className="p-5"><h2 className="text-lg font-black">Battle detail</h2><p className="mt-1 text-sm text-[var(--bb-muted)]">{selected ? selected.battleId : 'Chọn một battle để xem payload thật.'}</p><div className="mt-4"><JsonPanel value={detail ?? selected} /></div></SurfaceCard>
      </div>
    </div>
  );
}
