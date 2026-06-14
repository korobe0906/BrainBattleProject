import { Settings } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';

const envRows = [
  ['AUTH API', process.env.NEXT_PUBLIC_AUTH_API_URL || 'http://localhost:3000'],
  ['BATTLE API', process.env.NEXT_PUBLIC_BATTLE_API_URL || 'http://localhost:3001/api'],
  ['BATTLE SOCKET', process.env.NEXT_PUBLIC_BATTLE_SOCKET_URL || 'http://localhost:3001'],
];

export default function SettingsPage() {
  return <div className="space-y-6 pb-10"><PageHero eyebrow="Runtime Configuration" title="System Settings" description="Thông tin cấu hình frontend đang dùng để gọi auth/battle backend. Không chứa private key." icon={Settings} />
    <SurfaceCard className="p-5"><h2 className="text-lg font-black">Frontend environment</h2><div className="mt-4 overflow-hidden rounded-2xl border border-[var(--bb-border)]"><table className="w-full text-sm"><tbody>{envRows.map(([k, v]) => <tr key={k} className="border-t border-[var(--bb-border)] first:border-t-0"><td className="px-4 py-3 font-black">{k}</td><td className="px-4 py-3 text-[var(--bb-muted)]">{v}</td></tr>)}</tbody></table></div></SurfaceCard>
  </div>;
}
