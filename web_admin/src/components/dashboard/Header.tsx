'use client';

import Image from 'next/image';
import { usePathname } from 'next/navigation';
import { Download, UserPlus } from 'lucide-react';

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
  const hienTai =
    thongTinTrang[duongDan] || { tieuDe: 'Trang không xác định', moTa: '' };

  const laDashboard = duongDan === '/admin';
  const laDanhSachNguoiHoc = duongDan === '/admin/users/learners';

  return (
    <header
  className="w-full px-6 py-4 bg-white border-b border-gray-100
             text-gray-900 flex items-center justify-between sticky top-0 z-40"
>


      {/* Bên trái: Tiêu đề */}
      <div className="min-w-0">
        <h1 className="text-[20px] md:text-[22px] font-semibold tracking-wide truncate">
          {hienTai.tieuDe}
        </h1>
        {hienTai.moTa && (
          <p
            className="text-[13px] mt-0.5 truncate
                       bg-gradient-to-r from-pink-500 via-pink-400 to-purple-500
                       bg-clip-text text-transparent font-medium"
          >
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
                       bg-pink-100 text-pink-600 font-medium
                       border border-pink-200
                       hover:bg-pink-200 transition text-sm"
          >
            Live Data
          </button>

          <button
            type="button"
            className="inline-flex items-center gap-2
                       px-4 py-2 rounded-xl text-white font-semibold
                       bg-gradient-to-r from-pink-400 via-pink-500 to-purple-500
                       shadow-sm hover:opacity-90 transition text-sm"
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
                       px-4 py-2 rounded-xl text-white font-semibold
                       bg-gradient-to-r from-pink-400 via-pink-500 to-purple-500
                       shadow-sm hover:opacity-90 transition text-sm"
          >
            <UserPlus className="w-4 h-4" />
            Thêm người dùng
          </button>
        </div>
      ) : (
        <div className="relative w-10 h-10">
          <Image
            src="/images/brainbattle_logo_really_pink.png"
            alt="Logo BrainBattle"
            fill
            className="object-contain"
            priority
          />
        </div>
      )}
    </header>
  );
}
