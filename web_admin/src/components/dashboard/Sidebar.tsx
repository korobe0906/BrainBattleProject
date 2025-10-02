"use client";

import React, { useEffect, useMemo, useRef, useState } from "react";
import Link from "next/link";
import Image from "next/image";
import { usePathname, useRouter } from "next/navigation";
import gsap from "gsap";
import {
  LayoutDashboard,
  Users,
  UserX,
  Search,
  ClipboardList,
  FileCheck,
  Tag,
  BarChart2,
  Dumbbell,
  Medal,
  MessageSquare,
  AlertTriangle,
  ShieldCheck,
  CalendarCheck,
  Check,
  Reply,
  DollarSign,
  Cpu,
  BookOpenCheck,
  Bell,
  CalendarClock,
  Settings,
  Shield,
  LockKeyhole,
  ChevronRight,
  Video,
  Star,
  Sword,
  LogOut,
  X,
} from "lucide-react";
import { cn } from "@/lib/utils";

// =============================
// Types & Menu definition
// =============================
export type MenuItem = {
  label: string;
  icon: React.ElementType;
  href?: string;
  children?: MenuItem[];
};

const menu: MenuItem[] = [
  { label: "TỔNG QUAN", icon: LayoutDashboard, href: "/admin" },
  {
    label: "QUẢN LÝ NGƯỜI DÙNG",
    icon: Users,
    children: [
      { label: "Người học", icon: Users, href: "/admin/users/learners" },
      { label: "Creator & Quyền truy cập", icon: UserX, href: "/admin/users/creators" },
      { label: "Cảnh báo vi phạm", icon: AlertTriangle, href: "/admin/users/violations" },
      { label: "Tìm kiếm & phân loại", icon: Search, href: "/admin/users/search" },
    ],
  },
  {
    label: "NỘI DUNG HỌC",
    icon: BookOpenCheck,
    children: [
      { label: "Quản lý bài học AIM", icon: ClipboardList, href: "/admin/learning/units" },
      { label: "Ngân hàng câu hỏi", icon: Dumbbell, href: "/admin/learning/questions" },
      { label: "Import/Export nội dung", icon: FileCheck, href: "/admin/learning/import-export" },
      { label: "Thẻ metadata", icon: Tag, href: "/admin/learning/tags" },
    ],
  },
  {
    label: "KIỂM DUYỆT VIDEO",
    icon: Video,
    children: [
      { label: "Duyệt video người dùng", icon: Video, href: "/admin/videos/review" },
      { label: "Xử lý vi phạm", icon: AlertTriangle, href: "/admin/videos/violations" },
      { label: "Thống kê tương tác", icon: BarChart2, href: "/admin/videos/stats" },
      { label: "Đánh giá & xếp hạng", icon: Star, href: "/admin/videos/ratings" },
    ],
  },
  {
    label: "CLAN / GUILD",
    icon: Users,
    children: [
      { label: "Danh sách nhóm", icon: Users, href: "/admin/clans/list" },
      { label: "Lịch sử chat", icon: MessageSquare, href: "/admin/clans/chats" },
      { label: "Khóa nhóm vi phạm", icon: ShieldCheck, href: "/admin/clans/block" },
      { label: "Tìm theo chủ đề", icon: Search, href: "/admin/clans/search" },
    ],
  },
  {
    label: "TRẬN ĐẤU (BATTLE)",
    icon: Sword,
    children: [
      { label: "Lịch sử trận", icon: CalendarCheck, href: "/admin/battles/history" },
      { label: "Trận nghi vấn gian lận", icon: AlertTriangle, href: "/admin/battles/flags" },
      { label: "Bộ câu hỏi battle", icon: BookOpenCheck, href: "/admin/battles/questions" },
      { label: "Xếp hạng top", icon: Medal, href: "/admin/battles/ranking" },
    ],
  },
  {
    label: "PHÂN TÍCH HỆ THỐNG",
    icon: BarChart2,
    children: [
      { label: "Thống kê người học", icon: Users, href: "/admin/analytics/learners" },
      { label: "Doanh thu & vật phẩm", icon: DollarSign, href: "/admin/analytics/revenue" },
      { label: "So sánh thời gian", icon: CalendarClock, href: "/admin/analytics/compare" },
      { label: "Xuất báo cáo", icon: FileCheck, href: "/admin/analytics/export" },
    ],
  },
  {
    label: "HỖ TRỢ & BÁO CÁO",
    icon: MessageSquare,
    children: [
      { label: "Danh sách báo cáo", icon: AlertTriangle, href: "/admin/support/reports" },
      { label: "Trạng thái xử lý", icon: Check, href: "/admin/support/status" },
      { label: "FAQ / Câu hỏi thường gặp", icon: BookOpenCheck, href: "/admin/support/faq" },
      { label: "Feedback người dùng", icon: Reply, href: "/admin/support/feedback" },
    ],
  },
  {
    label: "HỆ THỐNG & CẤU HÌNH",
    icon: Settings,
    children: [
      { label: "Phân quyền", icon: Shield, href: "/admin/system/roles" },
      { label: "Nhật ký hoạt động", icon: LockKeyhole, href: "/admin/system/logs" },
      { label: "Backup & Restore", icon: Cpu, href: "/admin/system/backup" },
      { label: "Thiết lập cảnh báo", icon: Bell, href: "/admin/system/alerts" },
    ],
  },
];

// =============================
// Component
// =============================
export default function AdminSidebarHoverExpand() {
  const pathname = usePathname();
  const router = useRouter();
  const [openGroups, setOpenGroups] = useState<Record<string, boolean>>({});
  const [showLogout, setShowLogout] = useState(false);
  const [expanded, setExpanded] = useState(false); // Hover to expand
  const containerRef = useRef<HTMLDivElement | null>(null);
  const modalRef = useRef<HTMLDivElement | null>(null);

  // Animate sidebar slide-in on first render
  useEffect(() => {
    gsap.fromTo(
      containerRef.current,
      { x: -36, opacity: 0 },
      { x: 0, opacity: 1, duration: 0.4, ease: "power2.out" }
    );
  }, []);

  // Animate confirm modal
  useEffect(() => {
    if (showLogout) {
      gsap.fromTo(
        modalRef.current,
        { opacity: 0, scale: 0.95 },
        { opacity: 1, scale: 1, duration: 0.18, ease: "power2.out" }
      );
    }
  }, [showLogout]);

  const isChildActive = (children: MenuItem[]) =>
    children.some((ch) => ch.href && pathname.startsWith(ch.href));

  const toggleGroup = (label: string) => {
    setOpenGroups((prev) => ({ ...prev, [label]: !prev[label] }));
  };

  const confirmLogout = () => {
    try {
      localStorage.removeItem("bb_demo_login");
    } catch { }
    setShowLogout(false);
    router.push("/sign-in");
  };

  // Determine collapsed vs expanded width
  const sideWidth = expanded ? "w-72" : "w-[68px]"; // compact icon strip

  return (
    <>
      <aside
  ref={containerRef}
  onMouseEnter={() => setExpanded(true)}
  onMouseLeave={() => setExpanded(false)}
  className={cn(
    "h-full flex flex-col bg-white/95 backdrop-blur",
    "shadow-sm border border-gray-200",
    "overflow-y-auto",             
    sideWidth,
    "[transition:width_.25s_ease]"
  )}
  style={{
    borderTopRightRadius: 28,
    borderBottomRightRadius: 28,
  }}
>


        {/* Header */}
        <div className="p-4 border-b border-gray-200">
          <div className="flex items-center gap-3">
            <div className="relative w-9 h-9">
              <Image
                src="/images/brainbattle_logo_really_pink.png"
                alt="BrainBattle Logo"
                fill
                className="object-contain"
                priority
              />
            </div>
            {expanded && (
              <div className="leading-tight">
                <h1 className="text-[15px] font-semibold tracking-wide text-gray-900">
                  BRAIN BATTLE
                </h1>
                <p className="text-[12px] bg-gradient-to-r from-pink-500 to-purple-500 bg-clip-text text-transparent font-medium">
                  Learning Language System
                </p>
              </div>
            )}
          </div>
        </div>

        {/* NAV */}
        <nav
          className={cn(
            "flex-1 px-2 py-3 space-y-1 overflow-y-auto",
            "scrollbar-thin scrollbar-thumb-pink-200 scrollbar-track-transparent"
          )}
        >
          {menu.map((item) => {
            const isGroup = !!item.children;
            const isOpen =
              (isGroup && openGroups[item.label]) ||
              (isGroup && isChildActive(item.children!));
            const activeTop = !isGroup && pathname === item.href;

            // ===============
            // Collapsed view: icon-only + flyout on hover for groups
            // Expanded view: full labels; groups toggle to reveal children
            // ===============
            if (isGroup) {
              return (
                <div key={item.label} className="relative group">
                  {/* Top button / icon row */}
                  <button
                    onClick={() => expanded && toggleGroup(item.label)}
                    className={cn(
                      "w-full flex items-center gap-3 rounded-xl",
                      expanded ? "px-3 py-2.5" : "px-2.5 py-2",
                      "text-pink-600 hover:text-pink-700 hover:bg-pink-50 transition",
                      "ring-1 ring-transparent hover:ring-pink-200/60"
                    )}
                    aria-expanded={expanded ? isOpen : undefined}
                    aria-label={item.label}
                    title={!expanded ? item.label : undefined}
                  >
                    <item.icon className="w-5 h-5 shrink-0" />
                    {expanded && (
                      <>
                        <span className="font-medium text-[13.5px] flex-1 text-left">
                          {item.label}
                        </span>
                        <ChevronRight
                          className={cn(
                            "w-4 h-4 text-gray-400 transition-transform duration-200",
                            isOpen && "rotate-90"
                          )}
                        />
                      </>
                    )}
                  </button>

                  {/* Expanded mode: inline subtree */}
                  {expanded && isOpen && (
                    <div className="pl-10 mt-1 space-y-1.5">
                      {item.children!.map((child) => {
                        const active = pathname === child.href;
                        return (
                          <Link
                            key={child.label}
                            href={child.href!}
                            className={cn(
                              "relative flex items-center gap-2 px-2.5 py-2 rounded-lg transition",
                              "hover:bg-pink-50 hover:ring-1 hover:ring-pink-200/40",
                              active &&
                              "bg-gradient-to-r from-pink-100 to-purple-100 text-pink-700 font-semibold ring-1 ring-pink-300"
                            )}
                          >
                            <child.icon className="w-4 h-4 text-gray-500" />
                            <span className="text-[13.25px]">{child.label}</span>
                          </Link>
                        );
                      })}
                    </div>
                  )}

                  {/* Collapsed mode: flyout menu on hover */}
                  {!expanded && (
                    <div
                      className={cn(
                        "pointer-events-none absolute left-[64px] top-0 z-50 min-w-[220px]",
                        "opacity-0 translate-x-1 scale-[0.98]",
                        "group-hover:opacity-100 group-hover:translate-x-0 group-hover:scale-100",
                        "transition-all duration-150 origin-left"
                      )}
                    >
                      <div className="pointer-events-auto rounded-2xl border border-pink-200/60 bg-white shadow-xl p-2">
                        <div className="flex items-center gap-2 px-2 py-1.5">
                          <item.icon className="w-4 h-4 text-pink-600" />
                          <span className="text-[13.5px] font-semibold text-gray-800">
                            {item.label}
                          </span>
                        </div>
                        <div className="mt-1 space-y-1">
                          {item.children!.map((child) => {
                            const active = pathname === child.href;
                            return (
                              <Link
                                key={child.label}
                                href={child.href!}
                                className={cn(
                                  "flex items-center gap-2 rounded-lg px-2.5 py-2",
                                  "hover:bg-pink-50 hover:ring-1 hover:ring-pink-200/40",
                                  active &&
                                  "bg-gradient-to-r from-pink-100 to-purple-100 text-pink-700 font-semibold ring-1 ring-pink-300"
                                )}
                              >
                                <child.icon className="w-4 h-4 text-gray-500" />
                                <span className="text-[13px]">{child.label}</span>
                              </Link>
                            );
                          })}
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              );
            }

            // Single item (no children)
            return (
              <div key={item.label} className="relative group">
                <Link
                  href={item.href!}
                  className={cn(
                    "flex items-center rounded-xl transition",
                    expanded ? "px-3 py-2.5 gap-3" : "px-2.5 py-2 gap-0",
                    "hover:bg-pink-50 hover:ring-1 hover:ring-pink-200/40",
                    activeTop &&
                    "bg-gradient-to-r from-pink-100 to-purple-100 text-pink-700 font-semibold ring-1 ring-pink-300"
                  )}
                  aria-label={item.label}
                  title={!expanded ? item.label : undefined}
                >
                  <item.icon className="w-5 h-5 text-gray-600" />
                  {expanded && (
                    <span className="text-[13.5px] font-medium text-gray-800">
                      {item.label}
                    </span>
                  )}
                </Link>

                {/* Collapsed tooltip bubble (for single items) */}
                {!expanded && (
                  <div
                    className={cn(
                      "pointer-events-none absolute left-[64px] top-1/2 -translate-y-1/2 z-50",
                      "opacity-0 translate-x-1 scale-[0.98]",
                      "group-hover:opacity-100 group-hover:translate-x-0 group-hover:scale-100",
                      "transition-all duration-150 origin-left"
                    )}
                  >
                    <div className="pointer-events-auto rounded-xl border border-pink-200/60 bg-white shadow-xl px-2.5 py-1.5 text-[13px] font-medium text-gray-800">
                      {item.label}
                    </div>
                  </div>
                )}
              </div>
            );
          })}
        </nav>

        {/* Footer */}
        <div className="p-2.5 border-t border-gray-200">
          <button
            onClick={() => setShowLogout(true)}
            className={cn(
              "w-full flex items-center justify-center gap-2 rounded-xl",
              expanded ? "px-3 py-2.5" : "px-2.5 py-2",
              "text-pink-600 bg-pink-50 hover:bg-pink-100 ring-1 ring-pink-200 transition"
            )}
            aria-label="Đăng xuất"
            title={!expanded ? "Đăng xuất" : undefined}
          >
            <LogOut className="w-4 h-4" />
            {expanded && <span className="font-medium">Đăng xuất</span>}
          </button>
        </div>
      </aside>

      {/* Modal xác nhận */}
      {showLogout && (
        <div className="fixed inset-0 z-[60] flex items-center justify-center">
          <div
            className="absolute inset-0 bg-black/40"
            onClick={() => setShowLogout(false)}
          />
          <div
            ref={modalRef}
            className="relative w-[92%] max-w-sm rounded-2xl p-5 bg-white border border-gray-200 text-gray-900 shadow-xl"
          >
            <button
              onClick={() => setShowLogout(false)}
              className="absolute right-3 top-3 p-1 rounded-md hover:bg-gray-100"
              aria-label="Đóng"
            >
              <X className="w-4 h-4 text-gray-500" />
            </button>

            <h3 className="text-[18px] font-semibold mb-1">Đăng xuất?</h3>
            <p className="text-gray-600 mb-4">
              Bạn có chắc chắn muốn đăng xuất khỏi hệ thống không?
            </p>

            <div className="flex items-center justify-end gap-2">
              <button
                onClick={() => setShowLogout(false)}
                className="px-3 py-2 rounded-lg bg-gray-100 hover:bg-gray-200 text-gray-700"
              >
                Hủy
              </button>
              <button
                onClick={() => confirmLogout()}
                className="px-3 py-2 rounded-lg bg-gradient-to-r from-pink-500 to-purple-500 text-white hover:opacity-90"
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
