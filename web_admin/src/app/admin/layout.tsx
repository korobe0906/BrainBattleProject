'use client';

import { ReactNode } from 'react';
import Sidebar from '@/components/dashboard/Sidebar';
import Header from '@/components/dashboard/Header';

export default function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <div className="grid min-h-screen bg-[#F7F8FB] text-gray-900 
                    grid-cols-[auto,1fr] gap-4 px-3 py-3">
      {/* Cột trái: Sidebar sticky, cao = viewport trừ padding ngoài */}
      <div className="sticky top-3 left-3 h-[calc(100vh-24px)]">
        <Sidebar />
      </div>

      {/* Cột phải: Shell nội dung (card lớn) */}
      <div className="flex flex-col bg-white rounded-2xl border border-gray-200 
                      shadow-sm overflow-hidden">
        <Header />
        <main className="flex-1 overflow-y-auto p-6">
          {children}
        </main>
      </div>
    </div>
  );
}
