'use client';

import { ReactNode } from 'react';
import Sidebar from '@/components/dashboard/Sidebar';
import Header from '@/components/dashboard/Header';

export default function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex min-h-screen bg-[#F7F8FB] text-gray-900 gap-4 px-3 py-3">
      {/* Sidebar */}
      <Sidebar />

      {/* Shell nội dung (card lớn) */}
      <div className="flex flex-col flex-1 bg-white rounded-2xl border border-gray-200 shadow-sm overflow-hidden">
        {/* Header */}
        <Header />

        {/* Main Content */}
        <main className="flex-1 overflow-y-auto p-6">
          {children}
        </main>
      </div>
    </div>
  );
}
