'use client';

import { ReactNode } from 'react';
import Sidebar from '@/components/dashboard/Sidebar';
import Header from '@/components/dashboard/Header';

export default function AdminLayout({ children }: { children: ReactNode }) {
  return (
    <div className="flex min-h-screen bg-[#0F1117] text-white">
      {/* Sidebar */}
      <Sidebar />

      {/* Nội dung chính */}
      <div className="flex flex-col flex-1">
        {/* Header */}
        <Header />

        {/* Main Content */}
        <main className="flex-1 overflow-y-auto bg-[#1A1D24] text-white p-6">
          {children}
        </main>
      </div>
    </div>
  );
}
