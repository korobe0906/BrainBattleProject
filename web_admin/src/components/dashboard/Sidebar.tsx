'use client';

import {
  LayoutDashboard, Users, UserX, Search, ClipboardList, FileCheck, Tag, BarChart2,
  Dumbbell, Utensils, Puzzle, Medal, MessageSquare, AlertTriangle, ShieldCheck,
  CalendarCheck, Check, Reply, DollarSign, Cpu, BookOpenCheck, Bell, CalendarClock,
  Settings, Shield, LockKeyhole, ChevronRight, Video, Star, Sword, LogOut, X
} from 'lucide-react';

import Image from 'next/image';
import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { useState, useEffect, useRef } from 'react';
import gsap from 'gsap';
import { cn } from '@/lib/utils';

type MenuItem = {
  label: string;
  icon: React.ElementType;
  href?: string;
  children?: MenuItem[];
};

const menu: MenuItem[] = [
  { label: 'TỔNG QUAN', icon: LayoutDashboard, href: '/admin' },
  {
    label: 'QUẢN LÝ NGƯỜI DÙNG',
    icon: Users,
    children: [
      { label: 'Người học', icon: Users, href: '/admin/users/learners' },
      { label: 'Creator & Quyền truy cập', icon: UserX, href: '/admin/users/creators' },
      { label: 'Cảnh báo vi phạm', icon: AlertTriangle, href: '/admin/users/violations' },
      { label: 'Tìm kiếm & phân loại', icon: Search, href: '/admin/users/search' }
    ]
  },
  {
    label: 'NỘI DUNG HỌC',
    icon: BookOpenCheck,
    children: [
      { label: 'Quản lý bài học AIM', icon: ClipboardList, href: '/admin/learning/units' },
      { label: 'Ngân hàng câu hỏi', icon: Dumbbell, href: '/admin/learning/questions' },
      { label: 'Import/Export nội dung', icon: FileCheck, href: '/admin/learning/import-export' },
      { label: 'Thẻ metadata', icon: Tag, href: '/admin/learning/tags' }
    ]
  },
  {
    label: 'KIỂM DUYỆT VIDEO',
    icon: Video,
    children: [
      { label: 'Duyệt video người dùng', icon: Video, href: '/admin/videos/review' },
      { label: 'Xử lý vi phạm', icon: AlertTriangle, href: '/admin/videos/violations' },
      { label: 'Thống kê tương tác', icon: BarChart2, href: '/admin/videos/stats' },
      { label: 'Đánh giá & xếp hạng', icon: Star, href: '/admin/videos/ratings' }
    ]
  },
  {
    label: 'CLAN / GUILD',
    icon: Users,
    children: [
      { label: 'Danh sách nhóm', icon: Users, href: '/admin/clans/list' },
      { label: 'Lịch sử chat', icon: MessageSquare, href: '/admin/clans/chats' },
      { label: 'Khóa nhóm vi phạm', icon: ShieldCheck, href: '/admin/clans/block' },
      { label: 'Tìm theo chủ đề', icon: Search, href: '/admin/clans/search' }
    ]
  },
  {
    label: 'TRẬN ĐẤU (BATTLE)',
    icon: Sword,
    children: [
      { label: 'Lịch sử trận', icon: CalendarCheck, href: '/admin/battles/history' },
      { label: 'Trận nghi vấn gian lận', icon: AlertTriangle, href: '/admin/battles/flags' },
      { label: 'Bộ câu hỏi battle', icon: BookOpenCheck, href: '/admin/battles/questions' },
      { label: 'Xếp hạng top', icon: Medal, href: '/admin/battles/ranking' }
    ]
  },
  {
    label: 'PHÂN TÍCH HỆ THỐNG',
    icon: BarChart2,
    children: [
      { label: 'Thống kê người học', icon: Users, href: '/admin/analytics/learners' },
      { label: 'Doanh thu & vật phẩm', icon: DollarSign, href: '/admin/analytics/revenue' },
      { label: 'So sánh thời gian', icon: CalendarClock, href: '/admin/analytics/compare' },
      { label: 'Xuất báo cáo', icon: FileCheck, href: '/admin/analytics/export' }
    ]
  },
  {
    label: 'HỖ TRỢ & BÁO CÁO',
    icon: MessageSquare,
    children: [
      { label: 'Danh sách báo cáo', icon: AlertTriangle, href: '/admin/support/reports' },
      { label: 'Trạng thái xử lý', icon: Check, href: '/admin/support/status' },
      { label: 'FAQ / Câu hỏi thường gặp', icon: BookOpenCheck, href: '/admin/support/faq' },
      { label: 'Feedback người dùng', icon: Reply, href: '/admin/support/feedback' }
    ]
  },
  {
    label: 'HỆ THỐNG & CẤU HÌNH',
    icon: Settings,
    children: [
      { label: 'Phân quyền', icon: Shield, href: '/admin/system/roles' },
      { label: 'Nhật ký hoạt động', icon: LockKeyhole, href: '/admin/system/logs' },
      { label: 'Backup & Restore', icon: Cpu, href: '/admin/system/backup' },
      { label: 'Thiết lập cảnh báo', icon: Bell, href: '/admin/system/alerts' }
    ]
  }
];

export default function AdminSidebar() {
  const pathname = usePathname();
  const router = useRouter();
  const [openGroups, setOpenGroups] = useState<Record<string, boolean>>({});
  const [showLogout, setShowLogout] = useState(false);
  const sidebarRef = useRef<HTMLDivElement | null>(null);
  const modalRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    gsap.fromTo(sidebarRef.current, { x: -40, opacity: 0 }, { x: 0, opacity: 1, duration: 0.45, ease: 'power2.out' });
  }, []);

  useEffect(() => {
    if (showLogout) {
      gsap.fromTo(modalRef.current, { opacity: 0, scale: 0.96 }, { opacity: 1, scale: 1, duration: 0.18, ease: 'power2.out' });
    }
  }, [showLogout]);

  const toggleGroup = (label: string) => {
    const isOpening = !openGroups[label];
    setOpenGroups(prev => ({ ...prev, [label]: isOpening }));
    setTimeout(() => {
      const submenu = document.querySelector(`[data-submenu="${label}"]`);
      if (submenu) {
        gsap.fromTo(submenu, { height: 0, opacity: 0 }, { height: 'auto', opacity: 1, duration: 0.28, ease: 'power2.out' });
      }
    }, 30);
  };

  const isChildActive = (children: MenuItem[]) =>
    children.some(child => child.href && pathname.startsWith(child.href!));

  const confirmLogout = () => {
    // clear demo token if any
    try { localStorage.removeItem('bb_demo_login'); } catch {}
    setShowLogout(false);
    router.push('/sign-in'); 
  };

  return (
    <>
      <aside
        ref={sidebarRef}
        className="w-72 h-screen flex flex-col
               bg-gradient-to-b from-[#1A1D24] to-[#22252C]
               text-[#E8EAF0] border-r border-white/5
               shadow-[0_10px_30px_rgba(0,0,0,0.35)]"
      >
        {/* Header */}
        <div className="p-5 border-b border-white/5">
          <div className="flex items-center gap-3">
            <div className="relative w-10 h-10">
              <div className="absolute inset-0 rotate-[18deg]">
                <Image src="/images/frame_logo_yellow2.png" alt="BrainBattle Logo" fill className="object-contain" priority />
              </div>
              <div className="absolute inset-0 -rotate-[18deg] flex items-center justify-center text-white text-lg font-extrabold">B</div>
            </div>
            <div className="leading-tight">
              <h1 className="text-[15px] font-semibold tracking-wide">BRAIN BATTLE</h1>
              <p className="text-[12px] text-[#FFD84D]">Learning Language System</p>
            </div>
          </div>
        </div>

        {/* Nav */}
        <nav className="flex-1 px-3 py-4 space-y-2 text-[13.5px] overflow-y-auto
                    scrollbar-thin scrollbar-thumb-white/10 scrollbar-track-transparent">
          {menu.map(item => {
            const isOpen = openGroups[item.label] || (item.children && isChildActive(item.children));

            if (item.children) {
              return (
                <div key={item.label} className="group">
                  <button
                    onClick={() => toggleGroup(item.label)}
                    className="w-full flex items-center justify-between px-3 py-2.5 rounded-xl
                           text-[#FFD84D] hover:text-white
                           hover:bg-white/[0.07] transition
                           ring-1 ring-transparent hover:ring-[#FFD84D]/30"
                  >
                    <div className="flex items-center gap-2.5">
                      <item.icon className="w-5 h-5" />
                      <span className="font-medium">{item.label}</span>
                    </div>
                    <ChevronRight
                      className={cn(
                        'w-4 h-4 text-white/60 transition-transform duration-200',
                        isOpen && 'rotate-90'
                      )}
                    />
                  </button>

                  {isOpen && (
                    <div className="pl-8 mt-1 space-y-1.5" data-submenu={item.label}>
                      {item.children.map(child => {
                        const active = pathname === child.href;
                        return (
                          <Link
                            key={child.label}
                            href={child.href!}
                            className={cn(
                              'relative flex items-center gap-2 px-2.5 py-2 rounded-lg transition',
                              'hover:bg-white/[0.07] hover:ring-1 hover:ring-[#FFD84D]/25',
                              active && 'bg-[#262A32] text-white font-semibold ring-1 ring-[#FFD84D]/40'
                            )}
                          >
                            <span className={cn(
                              'absolute left-0 top-1/2 -translate-y-1/2 w-1 h-5 rounded-r-full bg-transparent',
                              active && 'bg-[#FFD84D]'
                            )} />
                            <child.icon className="w-4 h-4 text-white/70" />
                            <span>{child.label}</span>
                          </Link>
                        );
                      })}
                    </div>
                  )}
                </div>
              );
            }

            const active = pathname === item.href;
            return (
              <Link
                key={item.label}
                href={item.href!}
                className={cn(
                  'relative flex items-center gap-2 px-3 py-2.5 rounded-xl transition',
                  'hover:bg-white/[0.07] hover:ring-1 hover:ring-[#FFD84D]/30',
                  active && 'bg-[#262A32] text-white font-semibold ring-1 ring-[#FFD84D]/40'
                )}
              >
                <span className={cn(
                  'absolute left-0 top-1/2 -translate-y-1/2 w-1 h-5 rounded-r-full bg-transparent',
                  active && 'bg-[#FFD84D]'
                )} />
                <item.icon className="w-5 h-5 text-white/70" />
                <span>{item.label}</span>
              </Link>
            );
          })}
        </nav>

        {/* Footer: Đăng xuất */}
        <div className="p-3 border-t border-white/5">
          <button
            onClick={() => setShowLogout(true)}
            className="w-full flex items-center justify-center gap-2 px-3 py-2.5
                   rounded-xl text-[#E8EAF0] bg-white/5 hover:bg-white/10
                   ring-1 ring-white/10 hover:ring-[#FFD84D]/30 transition"
          >
            <LogOut className="w-4 h-4 text-[#FFD84D]" />
            <span className="font-medium">Đăng xuất</span>
          </button>
        </div>
      </aside>

      {/* Modal xác nhận */}
      {showLogout && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center">
          <div className="absolute inset-0 bg-black/50" onClick={() => setShowLogout(false)} />
          <div
            ref={modalRef}
            className="relative w-[92%] max-w-sm rounded-2xl p-5
                   bg-gradient-to-b from-[#1F232B] to-[#262A32]
                   border border-white/10 text-white shadow-[0_20px_60px_rgba(0,0,0,0.45)]"
          >
            <button
              onClick={() => setShowLogout(false)}
              className="absolute right-3 top-3 p-1 rounded-md hover:bg-white/10"
              aria-label="Đóng"
            >
              <X className="w-4 h-4 text-white/70" />
            </button>

            <h3 className="text-[18px] font-semibold mb-1">Đăng xuất?</h3>
            <p className="text-white/70 mb-4">Bạn có chắc chắn muốn đăng xuất khỏi hệ thống không?</p>

            <div className="flex items-center justify-end gap-2">
              <button
                onClick={() => setShowLogout(false)}
                className="px-3 py-2 rounded-lg bg-white/5 hover:bg-white/10 border border-white/10"
              >
                Hủy
              </button>
              <button
                onClick={confirmLogout}
                className="px-3 py-2 rounded-lg bg-rose-500/90 hover:bg-rose-500 text-white"
              >
                Đăng xuất
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
