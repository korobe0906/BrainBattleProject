'use client';

import StatCard from '@/components/dashboard/StatCard';
import { Eye, Target, Award, MessageCircle } from 'lucide-react';

export default function DashboardPage() {
  return (
<div className="space-y-6">
      {/* Grid thống kê */}
      <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">
        <StatCard
          icon={Eye}
          label="Điểm hiển thị"
          value="8.4"
          change="+12.5%"
          changeType="increase"
        />
        <StatCard
          icon={Target}
          label="Điểm hiện diện"
          value="74%"
          change="+8.2%"
          changeType="increase"
        />
        <StatCard
          icon={Award}
          label="Xếp hạng trung bình"
          value="2.3"
          change="-0.4"
          changeType="decrease"
        />
        <StatCard
          icon={MessageCircle}
          label="Lượt đề cập"
          value="1,247"
          change="+23.1%"
          changeType="increase"
        />
      </div>

      {/* Charts */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Line Chart card */}
        <div className="col-span-2 rounded-2xl p-6 bg-white border border-gray-200 shadow-sm hover:shadow-md transition">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h2 className="text-[18px] font-semibold text-gray-900">
                Xu hướng Điểm hiển thị &amp; Điểm hiện diện
              </h2>
              <p className="text-sm text-gray-500">
                Theo dõi hiệu suất thương hiệu trên các mô hình AI trong 7 ngày qua
              </p>
            </div>

            {/* Tabs giả lập */}
            <div className="flex items-center gap-2">
              <button className="px-3 py-1.5 text-sm rounded-full bg-gradient-to-r from-pink-400 to-purple-400 text-white font-medium">
                Hiển thị &amp; Hiện diện
              </button>
              <button className="px-3 py-1.5 text-sm rounded-full bg-gray-100 text-gray-600 hover:bg-gray-200 transition">
                Lượt đề cập &amp; Trích dẫn
              </button>
            </div>
          </div>

          <div className="h-[300px] rounded-xl bg-gray-100 border border-gray-200 flex items-center justify-center text-gray-500">
            📈 Biểu đồ đường (Line Chart) Placeholder
          </div>
        </div>

        {/* Donut card */}
        <div className="rounded-2xl p-6 bg-white border border-gray-200 shadow-sm hover:shadow-md transition">
          <h2 className="text-[18px] font-semibold text-gray-900 mb-1">
            Điểm tối ưu hóa trang
          </h2>
          <p className="text-sm text-gray-500 mb-4">
            Trạng thái tối ưu hóa hiển thị trên LLM
          </p>

          <div className="h-48 rounded-xl bg-gray-100 border border-gray-200 flex items-center justify-center text-gray-500">
            🥯 Biểu đồ tròn (Donut Chart) Placeholder
          </div>

          {/* Danh sách trạng thái (mock) */}
          <div className="mt-4 space-y-2">
            <div className="flex items-center justify-between rounded-xl bg-pink-50 px-3 py-2 text-pink-700 font-medium">
              <span>Nghiêm trọng</span>
              <span>2</span>
            </div>
            <div className="flex items-center justify-between rounded-xl bg-purple-50 px-3 py-2 text-purple-700 font-medium">
              <span>Cảnh báo</span>
              <span>5</span>
            </div>
            <div className="flex items-center justify-between rounded-xl bg-green-50 px-3 py-2 text-green-700 font-medium">
              <span>Ổn định</span>
              <span>12</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
