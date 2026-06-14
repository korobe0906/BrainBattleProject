'use client';

import { useEffect, useState } from 'react';
import { PackageCheck, RefreshCw, ShoppingBag } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { MetricCard } from '@/components/admin/MetricCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { StatusBadge } from '@/components/admin/StatusBadge';
import { SearchBox } from '@/components/admin/Toolbar';
import { ActionButton } from '@/components/admin/ActionButton';
import { adminBattleApi } from '@/lib/api/admin-battle';
import type { InventoryItem, ShopItem } from '@/types/battle-admin.types';

export default function ShopPage() {
  const [items, setItems] = useState<ShopItem[]>([]);
  const [inventory, setInventory] = useState<InventoryItem[]>([]);
  const [userId, setUserId] = useState('');
  async function reload() {
    const [i, inv] = await Promise.all([adminBattleApi.listShopItems(), adminBattleApi.listInventory(userId || undefined)]);
    setItems(i);
    setInventory(inv);
  }
  useEffect(() => { reload(); }, []);
  return <div className="space-y-6 pb-10"><PageHero eyebrow="BrainPoint Economy" title="Shop & Inventory" description="Kiểm tra item Star Protection, Double Reward, Rank Shield và inventory thật của người chơi." icon={ShoppingBag} />
    <div className="grid gap-4 md:grid-cols-3"><MetricCard icon={ShoppingBag} label="Shop items" value={items.length} /><MetricCard icon={PackageCheck} label="Inventory rows" value={inventory.length} /><MetricCard icon={RefreshCw} label="Active items" value={inventory.filter((i) => i.status === 'ACTIVE').length} /></div>
    <SurfaceCard className="p-5"><div className="flex flex-col gap-3 xl:flex-row"><SearchBox value={userId} onChange={setUserId} placeholder="Filter inventory by userId..." /><ActionButton variant="secondary" onClick={reload}><RefreshCw className="h-4 w-4" />Load</ActionButton></div></SurfaceCard>
    <div className="grid gap-6 xl:grid-cols-[0.9fr_1.3fr]"><SurfaceCard className="p-5"><h2 className="text-lg font-black">Shop items</h2><div className="mt-4 space-y-3">{items.length ? items.map((item) => <div key={item.code} className="rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-soft)] p-4"><div className="flex items-center justify-between"><p className="font-black">{item.name}</p><StatusBadge value={item.isActive ? 'ACTIVE' : 'BLOCKED'} /></div><p className="mt-1 text-sm text-[var(--bb-muted)]">{item.description}</p><p className="mt-3 text-2xl font-black text-[var(--bb-pink)]">{item.costBp} BP</p></div>) : <EmptyState title="Chưa có item" />}</div></SurfaceCard><SurfaceCard className="overflow-hidden">{inventory.length ? <div className="bb-scrollbar overflow-x-auto"><table className="bb-table"><thead><tr><th>User</th><th>Item</th><th>Status</th><th>Timeline</th><th>Battle</th></tr></thead><tbody>{inventory.map((item) => <tr key={item.id}><td><p className="font-black">{item.userId}</p><p className="text-xs text-[var(--bb-muted)]">{item.id}</p></td><td><p className="font-black">{item.item?.name ?? item.itemCode}</p><p className="text-xs text-[var(--bb-muted)]">{item.itemCode}</p></td><td><StatusBadge value={item.status} /></td><td className="text-xs text-[var(--bb-muted)]"><p>Buy: {item.acquiredAt ? new Date(item.acquiredAt).toLocaleString() : '-'}</p><p>Active: {item.activatedAt ? new Date(item.activatedAt).toLocaleString() : '-'}</p><p>Used: {item.usedAt ? new Date(item.usedAt).toLocaleString() : '-'}</p></td><td className="text-xs text-[var(--bb-muted)]">{item.battleId ?? '-'}</td></tr>)}</tbody></table></div> : <div className="p-5"><EmptyState title="Chưa có inventory" /></div>}</SurfaceCard></div>
  </div>;
}
