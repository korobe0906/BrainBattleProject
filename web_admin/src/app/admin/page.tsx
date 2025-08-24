'use client';

import StatCard from '@/components/dashboard/StatCard';
import { Eye, Target, Award, MessageCircle } from 'lucide-react';

export default function DashboardPage() {
  return (
    <div className="p-6 space-y-6 bg-gradient-to-b from-[#1A1D24] to-[#22252C] min-h-screen">
      {/* Grid thống kê */}
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
        <StatCard icon={Eye} label="Điểm hiển thị" value="8.4" change="+12.5%" changeType="increase" />
        <StatCard icon={Target} label="Điểm hiện diện" value="74%" change="+8.2%" changeType="increase" />
        <StatCard icon={Award} label="Xếp hạng trung bình" value="2.3" change="-0.4" changeType="decrease" />
        <StatCard icon={MessageCircle} label="Lượt đề cập" value="1,247" change="+23.1%" changeType="increase" />
      </div>

      {/* Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Line Chart card */}
        <div
          className="col-span-2 rounded-2xl p-6
                     bg-gradient-to-b from-[#1F232B] to-[#262A32]
                     border border-white/5 shadow-[0_8px_30px_rgba(0,0,0,0.25)]"
        >
          <div className="flex items-center justify-between mb-4">
            <div>
              <h2 className="text-[18px] font-semibold text-white">Xu hướng Điểm hiển thị & Điểm hiện diện</h2>
              <p className="text-sm text-white/70">
                Theo dõi hiệu suất thương hiệu trên các mô hình AI trong 7 ngày qua
              </p>
            </div>

            {/* Tabs giả lập */}
            <div className="flex items-center gap-2">
              <button className="px-3 py-1.5 text-sm rounded-full bg-[#2F3540] text-white/90 ring-1 ring-white/10">
                Hiển thị &amp; Hiện diện
              </button>
              <button className="px-3 py-1.5 text-sm rounded-full bg-white/5 text-white/70 hover:text-white hover:bg-white/10 transition">
                Lượt đề cập &amp; Trích dẫn
              </button>
            </div>
          </div>

          <div className="h-[300px] rounded-xl bg-[#2A2F38] border border-white/5
                          flex items-center justify-center text-white/70">
            📈 Biểu đồ đường (Line Chart) Placeholder
          </div>
        </div>

        {/* Donut card */}
        <div
          className="rounded-2xl p-6
                     bg-gradient-to-b from-[#1F232B] to-[#262A32]
                     border border-white/5 shadow-[0_8px_30px_rgba(0,0,0,0.25)]"
        >
          <h2 className="text-[18px] font-semibold text-white mb-1">Điểm tối ưu hóa trang</h2>
          <p className="text-sm text-white/70 mb-4">Trạng thái tối ưu hóa hiển thị trên LLM</p>

          <div className="h-48 rounded-xl bg-[#2A2F38] border border-white/5
                          flex items-center justify-center text-white/70">
            🥯 Biểu đồ tròn (Donut Chart) Placeholder
          </div>

          {/* Danh sách trạng thái (mock) */}
          <div className="mt-4 space-y-2">
            <div className="flex items-center justify-between rounded-xl bg-white/5 px-3 py-2">
              <span className="text-white/80">Nghiêm trọng</span>
              <span className="text-white/80">2</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
