'use client';

import { useState } from 'react';
import { Coins, RefreshCw, Wallet } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { SearchBox } from '@/components/admin/Toolbar';
import { ActionButton } from '@/components/admin/ActionButton';
import { JsonPanel } from '@/components/admin/JsonPanel';
import { adminBattleApi } from '@/lib/api/admin-battle';

export default function RewardsPage() {
  const [userId, setUserId] = useState('');
  const [wallet, setWallet] = useState<unknown>(null);
  const [ledger, setLedger] = useState<unknown>(null);
  const [error, setError] = useState('');

  async function load() {
    if (!userId.trim()) return;
    setError('');
    try {
      const [w, l] = await Promise.all([adminBattleApi.getRewardWallet(userId.trim()), adminBattleApi.getRewardLedger(userId.trim())]);
      setWallet(w);
      setLedger(l);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Cannot load reward data');
    }
  }

  return <div className="space-y-6 pb-10"><PageHero eyebrow="BrainPoint Ledger" title="Rewards" description="Tra cứu ví BP và ledger thật theo userId. Phần này dùng để đối soát reward sau trận, item purchase và txHash nếu đã settle on-chain." icon={Coins} />
    <SurfaceCard className="p-5"><div className="flex flex-col gap-3 xl:flex-row"><SearchBox value={userId} onChange={setUserId} placeholder="Nhập userId..." /><ActionButton onClick={load}><RefreshCw className="h-4 w-4" />Load reward</ActionButton></div>{error ? <p className="mt-3 text-sm font-bold text-[var(--bb-red)]">{error}</p> : null}</SurfaceCard>
    <div className="grid gap-6 xl:grid-cols-2"><SurfaceCard className="p-5"><div className="flex items-center gap-3"><Wallet className="h-5 w-5 text-[var(--bb-pink)]" /><h2 className="text-lg font-black">Wallet</h2></div><div className="mt-4">{wallet ? <JsonPanel value={wallet} /> : <EmptyState title="Chưa có wallet" description="Nhập userId thật để xem PlayerRewardWallet." />}</div></SurfaceCard><SurfaceCard className="p-5"><h2 className="text-lg font-black">Ledger</h2><div className="mt-4">{ledger ? <JsonPanel value={ledger} /> : <EmptyState title="Chưa có ledger" />}</div></SurfaceCard></div>
  </div>;
}
