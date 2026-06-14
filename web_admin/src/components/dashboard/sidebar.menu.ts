import { LucideIcon } from 'lucide-react';
import {
  ClipboardList,
  Crown,
  DoorOpen,
  FileQuestion,
  LayoutDashboard,
  ScrollText,
  Settings,
  ShieldCheck,
  ShoppingBag,
  Sword,
  Users,
  WalletCards,
} from 'lucide-react';

export interface MenuItem {
  label: string;
  icon: LucideIcon;
  href?: string;
  badge?: number;
  tone?: 'info' | 'warning' | 'danger';
  children?: MenuItem[];
}

export const menu: MenuItem[] = [
  { label: 'OVERVIEW', icon: LayoutDashboard, href: '/admin' },
  {
    label: 'USER MANAGEMENT',
    icon: Users,
    children: [{ label: 'Learners', icon: Users, href: '/admin/users/learners' }],
  },
  {
    label: 'BATTLE ECOSYSTEM',
    icon: Sword,
    children: [
      { label: 'Question Bank', icon: FileQuestion, href: '/admin/questions' },
      { label: 'Rooms', icon: DoorOpen, href: '/admin/rooms' },
      { label: 'Battles', icon: Sword, href: '/admin/battles' },
      { label: 'Ranking', icon: Crown, href: '/admin/ranking' },
    ],
  },
  {
    label: 'ECONOMY',
    icon: WalletCards,
    children: [
      { label: 'Reward Ledger', icon: ClipboardList, href: '/admin/rewards' },
      { label: 'Shop / Inventory', icon: ShoppingBag, href: '/admin/shop' },
    ],
  },
  {
    label: 'BLOCKCHAIN',
    icon: ShieldCheck,
    children: [{ label: 'Evidence Records', icon: ShieldCheck, href: '/admin/evidence' }],
  },
  {
    label: 'SYSTEM',
    icon: Settings,
    children: [
      { label: 'Audit Logs', icon: ScrollText, href: '/admin/audit-logs' },
      { label: 'Settings', icon: Settings, href: '/admin/settings' },
    ],
  },
];
