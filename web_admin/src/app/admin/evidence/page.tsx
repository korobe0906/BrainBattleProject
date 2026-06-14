'use client';

import { useEffect, useState } from 'react';
import { Link2, RefreshCw, ShieldCheck } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { StatusBadge } from '@/components/admin/StatusBadge';
import { SearchBox } from '@/components/admin/Toolbar';
import { ActionButton } from '@/components/admin/ActionButton';
import { JsonPanel } from '@/components/admin/JsonPanel';
import { adminBattleApi } from '@/lib/api/admin-battle';

export default function EvidencePage() {
  const [battleId, setBattleId] = useState('');
  const [record, setRecord] = useState<unknown>(null);
  const [payload, setPayload] = useState<unknown>(null);
  const [error, setError] = useState('');

  async function load() {
    if (!battleId.trim()) return;
    setError('');
    try {
      const [r, p] = await Promise.all([
        adminBattleApi.getOnchainRecord(battleId.trim()),
        adminBattleApi.getSettlementPayload(battleId.trim()).catch(() => null),
      ]);
      setRecord(r);
      setPayload(p);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Cannot load on-chain record');
      setRecord(null);
      setPayload(null);
    }
  }

  async function recordOnchain() {
    setRecord(await adminBattleApi.recordOnchain(battleId.trim()));
  }

  useEffect(() => { void 0; }, []);

  return <div className="space-y-6 pb-10">
    <PageHero eyebrow="Blockchain Traceability" title="On-chain Evidence" description="Tra cứu payload, resultHash, txHash và trạng thái ghi nhận trận battle trên smart contract. Nhập battleId thật để kiểm chứng bản ghi settlement và trạng thái on-chain." icon={ShieldCheck} />
    <SurfaceCard className="p-5"><div className="flex flex-col gap-3 xl:flex-row"><SearchBox value={battleId} onChange={setBattleId} placeholder="Nhập battleId cần kiểm chứng..." /><ActionButton variant="secondary" onClick={load}><RefreshCw className="h-4 w-4" />Load</ActionButton><ActionButton onClick={recordOnchain} disabled={!battleId.trim()}><Link2 className="h-4 w-4" />Record on-chain</ActionButton></div>{error ? <p className="mt-3 text-sm font-bold text-[var(--bb-red)]">{error}</p> : null}</SurfaceCard>
    <div className="grid gap-6 xl:grid-cols-2"><SurfaceCard className="p-5"><div className="flex items-center justify-between"><h2 className="text-lg font-black">Onchain record</h2><StatusBadge value={(record as any)?.status} /></div><div className="mt-4">{record ? <JsonPanel value={record} /> : <EmptyState title="Chưa có record" description="Backend chưa trả về on-chain record cho battleId này." />}</div></SurfaceCard><SurfaceCard className="p-5"><h2 className="text-lg font-black">Settlement payload</h2><p className="mt-1 text-sm text-[var(--bb-muted)]">Payload này phải khớp ABI contract.</p><div className="mt-4">{payload ? <JsonPanel value={payload} /> : <EmptyState title="Chưa có payload" />}</div></SurfaceCard></div>
  </div>;
}
