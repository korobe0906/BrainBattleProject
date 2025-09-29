'use client';

import { useEffect, useMemo, useRef, useState } from 'react';
import {
  Search, Filter, Mail, CheckCircle2, XCircle, Phone, Globe, Languages, Smartphone, Calendar,
  Eye, Pencil, Trash2, MoreVertical
} from 'lucide-react';

type AccountStatus = 'active' | 'suspended' | 'deleted';

type UserRow = {
  id: string;
  name: string;
  username: string;
  email: string;
  emailVerified: boolean;
  phone?: string;
  avatarUrl?: string;
  gender: 'Nam' | 'Nữ' | 'Khác';
  dob?: string;
  country: string;
  timezone: string;
  language: string;
  status: AccountStatus;
  createdAt: string;
  lastLogin?: string;
  lastDevice?: string;
};

/* -------------------- Dropdown Action Menu -------------------- */
function ActionMenu({
  onView,
  onEdit,
  onDelete,
}: {
  onView: () => void;
  onEdit: () => void;
  onDelete: () => void;
}) {
  const [open, setOpen] = useState(false);
  const boxRef = useRef<HTMLDivElement | null>(null);

  useEffect(() => {
    const onClick = (e: MouseEvent) => {
      if (boxRef.current && !boxRef.current.contains(e.target as Node)) setOpen(false);
    };
    const onKey = (e: KeyboardEvent) => { if (e.key === 'Escape') setOpen(false); };
    document.addEventListener('mousedown', onClick);
    document.addEventListener('keydown', onKey);
    return () => {
      document.removeEventListener('mousedown', onClick);
      document.removeEventListener('keydown', onKey);
    };
  }, []);

  return (
    <div className="relative inline-block" ref={boxRef}>
      <button
        onClick={() => setOpen(v => !v)}
        aria-haspopup="menu"
        aria-expanded={open}
        className="p-2 rounded-full bg-gray-100 hover:bg-gray-200 text-gray-600 transition"
      >
        <MoreVertical className="w-4 h-4" />
      </button>

      {open && (
        <div
          role="menu"
          className="absolute right-0 mt-2 w-36 rounded-xl overflow-hidden
                     bg-white border border-gray-200 shadow-lg z-10"
        >
          <button
            role="menuitem"
            onClick={() => { setOpen(false); onView(); }}
            className="w-full px-3 py-2 text-left text-sm text-gray-700 hover:bg-pink-50 flex items-center gap-2"
          >
            <Eye className="w-4 h-4" /> Xem
          </button>
          <button
            role="menuitem"
            onClick={() => { setOpen(false); onEdit(); }}
            className="w-full px-3 py-2 text-left text-sm text-gray-700 hover:bg-pink-50 flex items-center gap-2"
          >
            <Pencil className="w-4 h-4" /> Sửa
          </button>
          <button
            role="menuitem"
            onClick={() => { setOpen(false); onDelete(); }}
            className="w-full px-3 py-2 text-left text-sm text-rose-600 hover:bg-rose-50 flex items-center gap-2"
          >
            <Trash2 className="w-4 h-4" /> Xóa
          </button>
        </div>
      )}
    </div>
  );
}

/* -------------------- Page -------------------- */
export default function UserListPage() {
  const [users, setUsers] = useState<UserRow[]>([]);
  const [q, setQ] = useState('');
  const [status, setStatus] = useState<AccountStatus | 'Tất cả'>('Tất cả');

  useEffect(() => {
    setUsers([
      {
        id: '7f1a9f9e-5a7e-4df1-8a3b-9f1b2c3d4e5f',
        name: 'Nguyễn Văn A',
        username: 'nguyenvana',
        email: 'a@example.com',
        emailVerified: true,
        phone: '+84 912 345 678',
        gender: 'Nam',
        dob: '1998-03-12',
        country: 'VN',
        timezone: 'Asia/Ho_Chi_Minh',
        language: 'vi',
        status: 'active',
        createdAt: '2024-01-05T10:20:00Z',
        lastLogin: '2025-01-24T02:15:00Z',
        lastDevice: 'Chrome • Windows',
      },
      {
        id: 'b2c3d4e5-f6a7-48b9-9012-3456789abcde',
        name: 'Trần Thị B',
        username: 'tranthib',
        email: 'b@example.com',
        emailVerified: false,
        gender: 'Nữ',
        dob: '2000-11-02',
        country: 'VN',
        timezone: 'Asia/Ho_Chi_Minh',
        language: 'vi',
        status: 'suspended',
        createdAt: '2024-05-21T07:40:00Z',
        lastLogin: '2025-01-22T13:05:00Z',
        lastDevice: 'Safari • iOS',
      },
      {
        id: 'c3d4e5f6-a7b8-49c0-8123-456789abcdef',
        name: 'Lê Văn C',
        username: 'levanc',
        email: 'c@example.com',
        emailVerified: true,
        phone: '+84 987 654 321',
        gender: 'Nam',
        dob: '1995-07-30',
        country: 'US',
        timezone: 'America/Los_Angeles',
        language: 'en',
        status: 'active',
        createdAt: '2023-12-18T09:00:00Z',
        lastLogin: '2025-01-23T08:10:00Z',
        lastDevice: 'Edge • Windows',
      },
      {
        id: 'd4e5f6a7-b8c9-4ad1-9234-56789abcdef0',
        name: 'Phạm Nhật D',
        username: 'phamnhatd',
        email: 'd@example.com',
        emailVerified: false,
        gender: 'Khác',
        country: 'JP',
        timezone: 'Asia/Tokyo',
        language: 'ja',
        status: 'deleted',
        createdAt: '2024-07-02T04:12:00Z',
        lastLogin: '2024-12-30T15:30:00Z',
        lastDevice: 'Android App',
      },
    ]);
  }, []);

  const filtered = useMemo(() => {
    const text = q.trim().toLowerCase();
    return users.filter(u => {
      const okStatus = status === 'Tất cả' || u.status === status;
      const okQ =
        !text ||
        u.name.toLowerCase().includes(text) ||
        u.username.toLowerCase().includes(text) ||
        u.email.toLowerCase().includes(text) ||
        (u.phone ?? '').toLowerCase().includes(text) ||
        u.id.toLowerCase().includes(text);
      return okStatus && okQ;
    });
  }, [users, q, status]);

  const fmtDate = (iso?: string, withTime = true) => {
    if (!iso) return '—';
    const d = new Date(iso);
    return d.toLocaleString('vi-VN', withTime
      ? { hour12: false, day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' }
      : { day: '2-digit', month: '2-digit', year: 'numeric' });
  };

  const statusBadge = (s: AccountStatus) => {
    if (s === 'active') return 'bg-emerald-100 text-emerald-700 ring-1 ring-emerald-300';
    if (s === 'suspended') return 'bg-amber-100 text-amber-700 ring-1 ring-amber-300';
    return 'bg-rose-100 text-rose-700 ring-1 ring-rose-300';
  };

  return (
    <div className="space-y-5">
      {/* Tools */}
      <div className="rounded-2xl p-4 bg-white border border-gray-200 shadow-sm">
        <div className="flex flex-col md:flex-row gap-3 md:items-center md:justify-between">
          <div className="relative w-full md:max-w-md">
            <Search className="w-4 h-4 text-gray-400 absolute left-3 top-1/2 -translate-y-1/2" />
            <input
              value={q}
              onChange={e => setQ(e.target.value)}
              placeholder="Tìm theo tên, username, email, số điện thoại hoặc UUID…"
              className="w-full pl-9 pr-3 py-2 rounded-lg bg-gray-50 text-gray-800 placeholder:text-gray-400 border border-gray-200 focus:outline-none focus:ring-2 focus:ring-pink-400/50"
            />
          </div>

          <div className="flex items-center gap-2">
            <Filter className="w-4 h-4 text-gray-400" />
            <select
              value={status}
              onChange={e => setStatus(e.target.value as any)}
              className="px-3 py-2 rounded-lg bg-gray-50 text-gray-800 text-sm border border-gray-200 focus:outline-none focus:ring-2 focus:ring-pink-400/50"
            >
              <option>Tất cả</option>
              <option value="active">Hoạt động</option>
              <option value="suspended">Bị treo</option>
              <option value="deleted">Đã xóa</option>
            </select>
          </div>
        </div>
      </div>

      {/* Table */}
      <div className="overflow-x-auto rounded-2xl bg-white border border-gray-200 shadow-sm">
        <table className="min-w-full">
          <thead>
            <tr className="text-left text-gray-600 text-sm border-b border-gray-200">
              <th className="px-5 py-3 font-medium">Người dùng</th>
              <th className="px-5 py-3 font-medium">User ID (UUID)</th>
              <th className="px-5 py-3 font-medium">Trạng thái</th>
              <th className="px-5 py-3 font-medium">Ngày tạo</th>
              <th className="px-5 py-3 font-medium">Đăng nhập gần nhất</th>
              <th className="px-5 py-3 font-medium">Thiết bị gần nhất</th>
              <th className="px-5 py-3 font-medium text-center">Thao tác</th>
            </tr>
          </thead>

          <tbody className="text-sm">
            {filtered.map(u => (
              <tr key={u.id} className="border-b border-gray-100 hover:bg-gray-50 transition">
                {/* Người dùng */}
                <td className="px-5 py-3">
                  <div className="flex items-start gap-3">
                    <div className="w-9 h-9 rounded-full flex items-center justify-center font-bold uppercase bg-gradient-to-r from-pink-400 to-purple-400 text-white">
                      {u.avatarUrl ? (
                        <img
                          src={u.avatarUrl}
                          alt={u.name}
                          className="w-9 h-9 rounded-full object-cover"
                        />
                      ) : (
                        u.name.trim().charAt(0)
                      )}
                    </div>

                    <div className="space-y-0.5">
                      <div className="flex items-center gap-2">
                        <span className="text-gray-900 font-medium">{u.name}</span>
                        <span className="text-gray-400">•</span>
                        <span className="text-gray-500">@{u.username}</span>
                      </div>
                      <div className="flex flex-wrap items-center gap-2 text-gray-600">
                        <span className="inline-flex items-center gap-1">
                          <Mail className="w-4 h-4 text-gray-400" />
                          {u.email}
                        </span>
                        {u.emailVerified ? (
                          <span className="inline-flex items-center gap-1 text-emerald-600">
                            <CheckCircle2 className="w-4 h-4" /> Đã xác thực
                          </span>
                        ) : (
                          <span className="inline-flex items-center gap-1 text-amber-600">
                            <XCircle className="w-4 h-4" /> Chưa xác thực
                          </span>
                        )}
                        {u.phone && (
                          <span className="inline-flex items-center gap-1 text-gray-600">
                            <Phone className="w-4 h-4 text-gray-400" /> {u.phone}
                          </span>
                        )}
                        <span className="inline-flex items-center gap-1 text-gray-600">
                          <Globe className="w-4 h-4 text-gray-400" /> {u.country} • {u.timezone}
                        </span>
                        <span className="inline-flex items-center gap-1 text-gray-600">
                          <Languages className="w-4 h-4 text-gray-400" /> {u.language}
                        </span>
                        {u.dob && (
                          <span className="inline-flex items-center gap-1 text-gray-600">
                            <Calendar className="w-4 h-4 text-gray-400" /> {fmtDate(u.dob, false)}
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                </td>

                {/* UUID */}
                <td className="px-5 py-3"><code className="text-gray-500">{u.id}</code></td>

                {/* Trạng thái */}
                <td className="px-5 py-3">
                  <span className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs ${statusBadge(u.status)}`}>
                    {u.status === 'active' ? 'Hoạt động' : u.status === 'suspended' ? 'Bị treo' : 'Đã xóa'}
                  </span>
                </td>

                {/* Ngày tạo */}
                <td className="px-5 py-3 text-gray-600">{fmtDate(u.createdAt)}</td>

                {/* Đăng nhập gần nhất */}
                <td className="px-5 py-3 text-gray-600">{fmtDate(u.lastLogin)}</td>

                {/* Thiết bị gần nhất */}
                <td className="px-5 py-3">
                  <span className="inline-flex items-center gap-1.5 text-gray-600">
                    <Smartphone className="w-4 h-4 text-gray-400" />
                    {u.lastDevice ?? '—'}
                  </span>
                </td>

                {/* Thao tác */}
                <td className="px-5 py-3 text-center">
                  <ActionMenu
                    onView={() => console.log('Xem', u.id)}
                    onEdit={() => console.log('Sửa', u.id)}
                    onDelete={() => console.log('Xóa', u.id)}
                  />
                </td>
              </tr>
            ))}

            {filtered.length === 0 && (
              <tr>
                <td colSpan={7} className="px-5 py-10 text-center text-gray-500">
                  Không tìm thấy người dùng phù hợp.
                </td>
              </tr>
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}
