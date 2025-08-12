'use client';

import Image from 'next/image';
import Link from 'next/link';
import { useEffect, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import gsap from 'gsap';
import { Mail, User, AtSign, Lock, Eye, EyeOff, CheckCircle2 } from 'lucide-react';

export default function SignUpPage() {
  const router = useRouter();
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirm, setConfirm] = useState('');
  const [agree, setAgree] = useState(false);
  const [showPass, setShowPass] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [okMsg, setOkMsg] = useState<string | null>(null);

  const formRef = useRef<HTMLDivElement | null>(null);
  const ctaRef = useRef<HTMLButtonElement | null>(null);

  useEffect(() => {
    gsap.fromTo(formRef.current, { y: 10, opacity: 0 }, { y: 0, opacity: 1, duration: 0.45, ease: 'power3.out' });
  }, []);

  const validate = () => {
    if (!fullName.trim()) return 'Vui lòng nhập họ tên.';
    if (!/^\S+@\S+\.\S+$/.test(email)) return 'Email không hợp lệ.';
    if (username.length < 3) return 'Username tối thiểu 3 ký tự.';
    if (password.length < 6) return 'Mật khẩu tối thiểu 6 ký tự.';
    if (password !== confirm) return 'Xác nhận mật khẩu không khớp.';
    if (!agree) return 'Bạn cần đồng ý với Điều khoản.';
    return null;
  };

  const onSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (loading) return;
    setErr(null);

    const v = validate();
    if (v) {
      setErr(v);
      gsap.fromTo(formRef.current, { x: -6 }, { x: 0, duration: 0.25, ease: 'elastic.out(1,0.6)' });
      return;
    }

    setLoading(true);
    setOkMsg('Tạo tài khoản thành công! Đang chuyển…');
    gsap.to(ctaRef.current, { scale: 0.98, duration: 0.12, yoyo: true, repeat: 1, ease: 'power2.inOut' });
    gsap.to(formRef.current, { opacity: 0.8, duration: 0.2 });
    setTimeout(() => router.push('/signin'), 600);
  };

  return (
    <div ref={formRef}>
      {/* Header nhỏ */}
      <div className="flex items-center mb-6">
        <div className="relative w-10 h-10 rotate-315 mr-2">
          <Image src="/images/frame_logo.png" alt="BrainBattle Logo" fill className="object-contain" priority />
          <div className="absolute inset-0 flex items-center justify-center text-white text-base font-extrabold">B</div>
        </div>
        <h1 className="text-xl font-semibold text-gray-800">Brain Battle</h1>
      </div>

      <h2 className="text-lg font-medium text-gray-900 mb-2">Tạo tài khoản</h2>
      <p className="text-sm text-gray-500 mb-6">Bắt đầu hành trình học tập của bạn</p>

      <form className="space-y-5" onSubmit={onSubmit}>
        <div>
          <label className="block text-sm text-gray-500 mb-1">Họ tên</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <User className="w-4 h-4 text-gray-400" />
            <input value={fullName} onChange={e => setFullName(e.target.value)} placeholder="Họ và tên" className="w-full py-2 outline-none placeholder:text-gray-400" />
          </div>
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Email</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <Mail className="w-4 h-4 text-gray-400" />
            <input value={email} onChange={e => setEmail(e.target.value)} type="email" placeholder="Địa chỉ email" className="w-full py-2 outline-none placeholder:text-gray-400" />
          </div>
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Tên đăng nhập</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <AtSign className="w-4 h-4 text-gray-400" />
            <input value={username} onChange={e => setUsername(e.target.value)} placeholder="Username duy nhất" className="w-full py-2 outline-none placeholder:text-gray-400" />
          </div>
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Mật khẩu</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <Lock className="w-4 h-4 text-gray-400" />
            <input value={password} onChange={e => setPassword(e.target.value)} type={showPass ? 'text' : 'password'} placeholder="Tạo mật khẩu" className="w-full py-2 outline-none placeholder:text-gray-400" />
            <button type="button" onClick={() => setShowPass(v => !v)} className="p-1 text-gray-500 hover:text-gray-700">
              {showPass ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
            </button>
          </div>
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Xác nhận mật khẩu</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <Lock className="w-4 h-4 text-gray-400" />
            <input value={confirm} onChange={e => setConfirm(e.target.value)} type={showConfirm ? 'text' : 'password'} placeholder="Nhập lại mật khẩu" className="w-full py-2 outline-none placeholder:text-gray-400" />
            <button type="button" onClick={() => setShowConfirm(v => !v)} className="p-1 text-gray-500 hover:text-gray-700">
              {showConfirm ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
            </button>
          </div>
        </div>

        <div className="flex items-center gap-2 text-sm text-gray-600">
          <input id="agree" type="checkbox" className="rounded border-gray-300" checked={agree} onChange={e => setAgree(e.target.checked)} />
          <label htmlFor="agree">
            Tôi đồng ý với <a href="#" className="text-gray-900 font-medium hover:underline">Điều khoản</a> và <a href="#" className="text-gray-900 font-medium hover:underline">Chính sách</a>
          </label>
        </div>

        {err && <p className="text-sm text-red-600">{err}</p>}
        {okMsg && <p className="text-sm text-emerald-600 flex items-center gap-1"><CheckCircle2 className="w-4 h-4" />{okMsg}</p>}

        <button ref={ctaRef} type="submit" disabled={loading} className="w-full rounded-full py-3 text-black font-semibold bg-yellow-400 hover:bg-yellow-300 transition disabled:opacity-70">
          {loading ? 'Đang tạo tài khoản…' : 'Tạo tài khoản'}
        </button>

        <p className="text-center text-sm text-gray-600">
          Đã có tài khoản? <Link href="/sign-in" className="text-gray-900 font-medium hover:underline">Đăng nhập</Link>
        </p>
      </form>
    </div>
  );
}
