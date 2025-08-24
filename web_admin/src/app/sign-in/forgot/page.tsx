'use client';

import Image from 'next/image';
import Link from 'next/link';
import { useEffect, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import gsap from 'gsap';
import { Mail, CheckCircle2, ArrowLeft } from 'lucide-react';

export default function ForgotPasswordPage() {
  const router = useRouter();

  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [okMsg, setOkMsg] = useState<string | null>(null);

  const formRef = useRef<HTMLDivElement | null>(null);
  const ctaRef = useRef<HTMLButtonElement | null>(null);

  useEffect(() => {
    gsap.fromTo(formRef.current, { y: 10, opacity: 0 }, { y: 0, opacity: 1, duration: 0.45, ease: 'power3.out' });
  }, []);

  const validate = () => {
    if (!email.trim() || !/^\S+@\S+\.\S+$/.test(email)) return 'Email không hợp lệ.';
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
    setOkMsg('Đã gửi liên kết đặt lại mật khẩu vào email của bạn.');
    gsap.to(ctaRef.current, { scale: 0.98, duration: 0.12, yoyo: true, repeat: 1, ease: 'power2.inOut' });
    gsap.to(formRef.current, { opacity: 0.85, duration: 0.2 });

    // Fake API + tự động quay về trang đăng nhập
    setTimeout(() => router.push('/sign-in'), 2500);
  };

  return (
    <div ref={formRef} className="w-full max-w-md">
      {/* Header nhỏ */}
      <div className="flex items-center mb-6">
        <button
          onClick={() => router.back()}
          className="mr-2 p-1 rounded hover:bg-gray-100 text-gray-600"
          aria-label="Quay lại"
        >
          <ArrowLeft className="w-5 h-5" />
        </button>

        <div className="relative w-10 h-10 rotate-315 mr-2">
          <Image src="/images/frame_logo.png" alt="BrainBattle Logo" fill className="object-contain" priority />
          <div className="absolute inset-0 flex items-center justify-center text-white text-base font-extrabold">
            B
          </div>
        </div>
        <h1 className="text-xl font-semibold text-gray-800">Brain Battle</h1>
      </div>

      <h2 className="text-lg font-medium text-gray-900 mb-2">Quên mật khẩu</h2>
      <p className="text-sm text-gray-500 mb-6">
        Nhập email bạn đã đăng ký. Chúng tôi sẽ gửi liên kết để đặt lại mật khẩu.
      </p>

      {/* Form (underline style) */}
      <form className="space-y-5" onSubmit={onSubmit}>
        <div>
          <label className="block text-sm text-gray-500 mb-1">Email</label>
          <div className="flex items-center gap-2 border-b border-gray-300 focus-within:border-black">
            <Mail className="w-4 h-4 text-gray-400" />
            <input
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              type="email"
              placeholder="Địa chỉ email"
              className="w-full py-2 outline-none placeholder:text-gray-400"
              autoComplete="email"
            />
          </div>
        </div>

        {/* Error / Success */}
        {err && <p className="text-sm text-red-600">{err}</p>}
        {okMsg && (
          <p className="text-sm text-emerald-600 flex items-center gap-1">
            <CheckCircle2 className="w-4 h-4" /> {okMsg} (đang chuyển…)
          </p>
        )}

        {/* CTA */}
        <button
          ref={ctaRef}
          type="submit"
          disabled={loading}
          className="w-full rounded-full py-3 text-black font-semibold bg-yellow-400 hover:bg-yellow-300 transition disabled:opacity-70"
        >
          {loading ? 'Đang gửi…' : 'Gửi liên kết đặt lại'}
        </button>

        <p className="text-center text-sm text-gray-600">
          Nhớ mật khẩu rồi?{' '}
          <Link href="/sign-in" className="text-gray-900 font-medium hover:underline">
            Đăng nhập
          </Link>
        </p>
      </form>
    </div>
  );
}
