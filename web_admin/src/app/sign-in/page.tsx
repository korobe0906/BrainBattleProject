'use client';

import Image from 'next/image';
import Link from 'next/link';
import { useEffect, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import gsap from 'gsap';
import { Mail, Lock, Eye, EyeOff } from 'lucide-react';

export default function SignInPage() {
  const router = useRouter();
  const [showPass, setShowPass] = useState(false);
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [remember, setRemember] = useState(false);
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const formWrapRef = useRef<HTMLDivElement | null>(null);
  const ctaRef = useRef<HTMLButtonElement | null>(null);

  useEffect(() => {
    gsap.fromTo(formWrapRef.current, { y: 10, opacity: 0 }, { y: 0, opacity: 1, duration: 0.45, ease: 'power3.out' });
  }, []);

  const onSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (loading) return;
    setErr(null);

    if (username.trim() === 'admin' && password === 'admin123') {
      setLoading(true);
      gsap.to(ctaRef.current, { scale: 0.98, duration: 0.12, yoyo: true, repeat: 1, ease: 'power2.inOut' });
      gsap.to(formWrapRef.current, { opacity: 0.75, duration: 0.2 });
      if (remember) localStorage.setItem('bb_demo_login', '1');
      setTimeout(() => router.push('/admin'), 350);
    } else {
      setErr('Sai tài khoản hoặc mật khẩu.');
      gsap.fromTo(formWrapRef.current, { x: -6 }, { x: 0, duration: 0.25, ease: 'elastic.out(1,0.6)' });
    }
  };

  return (
    <div ref={formWrapRef}>
      {/* Header nhỏ */}
      <div className="flex items-center mb-6">
        <div className="relative w-10 h-10 rotate-315 mr-2">
          <Image src="/images/frame_logo.png" alt="BrainBattle Logo" fill className="object-contain" priority />
          <div className="absolute inset-0 flex items-center justify-center text-white text-base font-extrabold">B</div>
        </div>
        <h1 className="text-xl font-semibold text-gray-800">Brain Battle</h1>
      </div>

      <p className="text-sm text-gray-500 mb-6">Đăng nhập để tiếp tục</p>

      {/* Form underline */}
      <form className="space-y-5" onSubmit={onSubmit}>
        <div>
          <label className="block text-sm text-gray-500 mb-1">Tài khoản</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <Mail className="w-4 h-4 text-gray-400" />
            <input
              value={username}
              onChange={e => setUsername(e.target.value)}
              type="text"
              placeholder="Email hoặc username"
              className="w-full py-2 outline-none placeholder:text-gray-400"
              autoComplete="username"
            />
          </div>
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Mật khẩu</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <Lock className="w-4 h-4 text-gray-400" />
            <input
              value={password}
              onChange={e => setPassword(e.target.value)}
              type={showPass ? 'text' : 'password'}
              placeholder="Nhập mật khẩu"
              className="w-full py-2 outline-none placeholder:text-gray-400"
              autoComplete="current-password"
            />
            <button type="button" onClick={() => setShowPass(v => !v)} className="p-1 text-gray-500 hover:text-gray-700">
              {showPass ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
            </button>
          </div>
        </div>

        {err && <p className="text-sm text-red-600">{err}</p>}

        <div className="flex justify-between items-center text-sm text-gray-600">
          <label className="flex items-center gap-2">
            <input type="checkbox" checked={remember} onChange={e => setRemember(e.target.checked)} />
            Ghi nhớ đăng nhập
          </label>
          <Link href="/sign-in/forgot" className="text-blue-500 hover:underline">Quên mật khẩu?</Link>
        </div>

        <button
          ref={ctaRef}
          type="submit"
          disabled={loading}
          className="w-full rounded-full py-3 text-black font-semibold bg-yellow-400 hover:bg-yellow-300 transition disabled:opacity-70"
        >
          {loading ? 'Đang xử lý…' : 'Đăng nhập'}
        </button>

        <p className="text-sm text-center text-gray-700">
          Chưa có tài khoản? <Link href="/sign-in/signup" className="text-blue-500 hover:underline">Đăng ký</Link>
        </p>
      </form>
    </div>
  );
}
