import AdminAuthGuard from '@/components/auth/AdminAuthGuard';
import { AdminTopNav } from '@/components/admin/AdminTopNav';

export default function AdminLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <AdminAuthGuard>
      <div className="min-h-screen bg-[var(--bb-bg)] text-[var(--bb-text)]">
        <AdminTopNav />
        <main className="px-4 py-6 md:px-6 lg:px-8">
          <div className="mx-auto w-full max-w-[1480px]">{children}</div>
        </main>
      </div>
    </AdminAuthGuard>
  );
}
