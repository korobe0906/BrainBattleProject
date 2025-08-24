'use client';

import Image from 'next/image';
import { usePathname } from 'next/navigation';
import { Download, UserPlus } from 'lucide-react'; // thêm icon UserPlus

// Thông tin tiêu đề & mô tả cho từng trang
const thongTinTrang: Record<string, { tieuDe: string; moTa: string }> = {
  '/admin': {
    tieuDe: 'Bảng điều khiển',
    moTa: 'Theo dõi mức độ hiển thị thương hiệu của bạn trên các mô hình AI',
  },
  '/admin/users/learners': {
    tieuDe: 'Danh sách người học',
    moTa: 'Quản lý thông tin học viên trong hệ thống',
  },
  '/admin/users': {
    tieuDe: 'Quản lý người dùng',
    moTa: 'Thống kê và kiểm soát người dùng hệ thống',
  },
  '/admin/users/creators': {
    tieuDe: 'Creator & Quyền truy cập',
    moTa: 'Quản lý creator và phân quyền nâng cao',
  },
  // ... thêm route khác nếu cần
};

export default function Header() {
  const duongDan = usePathname();
  const hienTai = thongTinTrang[duongDan] || { tieuDe: 'Trang không xác định', moTa: '' };
  const laDashboard = duongDan === '/admin';
  const laDanhSachNguoiHoc = duongDan === '/admin/users/learners';

  return (
    <header
      className="w-full px-6 py-4
                 bg-gradient-to-r from-[#1A1D24] to-[#22252C]
                 border-b border-white/5
                 text-[#E8EAF0] flex items-center justify-between
                 sticky top-0 z-40"
    >
      {/* Bên trái: Tiêu đề */}
      <div className="min-w-0">
        <h1 className="text-[20px] md:text-[22px] font-semibold tracking-wide truncate">
          {hienTai.tieuDe}
        </h1>
        {hienTai.moTa && (
          <p className="text-[13px] text-[#FFD84D] mt-0.5 truncate">
            {hienTai.moTa}
          </p>
        )}
      </div>

      {/* Bên phải */}
      {laDashboard ? (
        <div className="flex items-center gap-3">
          <button
            type="button"
            className="px-4 py-2 rounded-full
                       bg-white/10 text-white/90
                       border border-white/10
                       hover:bg-white/15 hover:border-white/20
                       transition text-sm"
          >
            Live Data
          </button>

          <button
            type="button"
            className="inline-flex items-center gap-2
                       px-4 py-2 rounded-xl
                       bg-[#FFD84D] text-black font-semibold
                       shadow-[0_6px_20px_rgba(255,216,77,0.25)]
                       hover:bg-[#FFE169]
                       transition text-sm"
          >
            <Download className="w-4 h-4" />
            Xuất báo cáo
          </button>
        </div>
      ) : laDanhSachNguoiHoc ? (
        <div>
          <button
            type="button"
            className="inline-flex items-center gap-2
                       px-4 py-2 rounded-xl
                       bg-[#FFD84D] text-black font-semibold
                       shadow-[0_6px_20px_rgba(255,216,77,0.25)]
                       hover:bg-[#FFE169]
                       transition text-sm"
          >
            <UserPlus className="w-4 h-4" />
            Thêm người dùng
          </button>
        </div>
      ) : (
        <div className="relative w-10 h-10">
          <div className="absolute inset-0 rotate-[18deg]">
            <Image
              src="/images/frame_logo.png"
              alt="Logo BrainBattle"
              fill
              className="object-contain"
              priority
            />
          </div>
          <div className="absolute inset-0 -rotate-[18deg] flex items-center justify-center text-white text-lg font-extrabold">
            B
          </div>
        </div>
      )}
    </header>
  );
}
