'use client';

import { useEffect, useState } from 'react';
import { DoorOpen, RefreshCw, UsersRound, XCircle } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { MetricCard } from '@/components/admin/MetricCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { StatusBadge } from '@/components/admin/StatusBadge';
import { SearchBox, SelectFilter } from '@/components/admin/Toolbar';
import { ActionButton } from '@/components/admin/ActionButton';
import { JsonPanel } from '@/components/admin/JsonPanel';
import { adminBattleApi, unwrapItems } from '@/lib/api/admin-battle';
import type { AdminRoom } from '@/types/battle-admin.types';

const statuses = ['All', 'WAITING', 'READY', 'PLAYING', 'FINISHED', 'CANCELLED', 'EXPIRED'];
const formats = ['All', 'DUEL_1V1', 'TEAM_3V3'];

export default function RoomsPage() {
  const [rooms, setRooms] = useState<AdminRoom[]>([]);
  const [detail, setDetail] = useState<unknown>(null);
  const [code, setCode] = useState('');
  const [status, setStatus] = useState('All');
  const [format, setFormat] = useState('All');
  const [loading, setLoading] = useState(true);

  async function reload() {
    setLoading(true);
    try {
      const data = await adminBattleApi.listRooms({ code: code || undefined, status: status === 'All' ? undefined : status, format: format === 'All' ? undefined : format, page: 1, limit: 80 });
      setRooms(unwrapItems(data));
    } finally { setLoading(false); }
  }
  useEffect(() => { reload(); }, []);
  async function inspect(room: AdminRoom) { setDetail(await adminBattleApi.getRoom(room.id)); }
  async function cancel(room: AdminRoom) { setDetail(await adminBattleApi.forceCancelRoom(room.id)); await reload(); }
  return <div className="space-y-6 pb-10"><PageHero eyebrow="Room State Monitor" title="Rooms" description="Theo dõi lobby/team slot/role/ready check của battle room. Admin có thể force cancel room bị kẹt." icon={DoorOpen} />
    <div className="grid gap-4 md:grid-cols-3"><MetricCard icon={DoorOpen} label="Rooms" value={rooms.length} /><MetricCard icon={UsersRound} label="Members" value={rooms.reduce((s, r) => s + (r.members?.length ?? 0), 0)} /><MetricCard icon={XCircle} label="Cancelled" value={rooms.filter((r) => r.status === 'CANCELLED').length} /></div>
    <SurfaceCard className="p-5"><div className="flex flex-col gap-3 xl:flex-row"><SearchBox value={code} onChange={setCode} placeholder="Room code..." /><SelectFilter value={status} onChange={setStatus} options={statuses} /><SelectFilter value={format} onChange={setFormat} options={formats} /><ActionButton variant="secondary" onClick={reload}><RefreshCw className="h-4 w-4" />Load</ActionButton></div></SurfaceCard>
    <div className="grid gap-6 xl:grid-cols-[1.4fr_1fr]"><SurfaceCard className="overflow-hidden">{!loading && !rooms.length ? <div className="p-5"><EmptyState title="Chưa có room" /></div> : null}{rooms.length ? <div className="bb-scrollbar overflow-x-auto"><table className="bb-table"><thead><tr><th>Room</th><th>Format</th><th>Status</th><th>Members</th><th>Expires</th><th>Actions</th></tr></thead><tbody>{rooms.map((room) => <tr key={room.id}><td><p className="font-black">{room.code}</p><p className="text-xs text-[var(--bb-muted)]">{room.id}</p></td><td><StatusBadge value={room.format} /><p className="mt-2 text-xs text-[var(--bb-muted)]">{room.skill}</p></td><td><StatusBadge value={room.status} /></td><td>{room.members?.length ?? 0}</td><td className="text-xs text-[var(--bb-muted)]">{room.expiresAt ? new Date(room.expiresAt).toLocaleString() : '-'}</td><td><div className="flex gap-2"><ActionButton variant="secondary" onClick={() => inspect(room)}>Inspect</ActionButton><ActionButton variant="danger" onClick={() => cancel(room)}>Cancel</ActionButton></div></td></tr>)}</tbody></table></div> : null}</SurfaceCard><SurfaceCard className="p-5"><h2 className="text-lg font-black">Room detail</h2><div className="mt-4"><JsonPanel value={detail} /></div></SurfaceCard></div>
  </div>;
}
