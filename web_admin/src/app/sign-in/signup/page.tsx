'use client';

import Image from 'next/image';
import { useEffect, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import gsap from 'gsap';
import { Mail, Lock, UserRound, Eye, EyeOff, ArrowLeft, CheckCircle2 } from 'lucide-react';
import GsapUnderlineField from '@/components/gsap/GsapUnderlineField';
import GradientLink from '@/components/gsap/GradientLink';

export default function SignUpPage() {
  const router = useRouter();
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [pass, setPass] = useState('');
  const [confirm, setConfirm] = useState('');
  const [showPass, setShowPass] = useState(false);
  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const [okMsg, setOkMsg] = useState<string | null>(null);

  const formRef = useRef<HTMLDivElement | null>(null);
  const ctaRef = useRef<HTMLButtonElement | null>(null);
  const shineRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    gsap.fromTo(formRef.current, { y: 10, opacity: 0 }, { y: 0, opacity: 1, duration: 0.45, ease: 'power3.out' });
  }, []);

  const validate = () => {
    if (!name.trim()) return 'Vui lòng nhập tên.';
    if (!/^\S+@\S+\.\S+$/.test(email)) return 'Email không hợp lệ.';
    if (pass.length < 6) return 'Mật khẩu tối thiểu 6 ký tự.';
    if (pass !== confirm) return 'Xác nhận mật khẩu không khớp.';
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
    setOkMsg('Tạo tài khoản thành công! Đang chuyển đến đăng nhập…');
    gsap.to(ctaRef.current, { scale: 0.98, duration: 0.12, yoyo: true, repeat: 1, ease: 'power2.inOut' });
    gsap.to(formRef.current, { opacity: 0.85, duration: 0.2 });
    setTimeout(() => router.push('/sign-in'), 2000);
  };

  const onCtaEnter = () => {
    const el = ctaRef.current, shine = shineRef.current;
    if (!el || !shine) return;
    gsap.set(shine, { xPercent: -60, opacity: 0.9, scale: 0.95 });
    const tl = gsap.timeline({ defaults: { ease: 'power2.out' } });
    tl.to(el, { backgroundPosition: '100% 0%', duration: 0.8 }, 0)
      .to(shine, { xPercent: 160, scale: 1.05, duration: 0.8 }, 0)
      .to(el, { boxShadow: '0 0 20px rgba(236,72,153,.6)', duration: 0.3 }, 0);
  };
  const onCtaLeave = () => {
    const el = ctaRef.current;
    if (!el) return;
    gsap.to(el, { backgroundPosition: '0% 0%', boxShadow: '0 0 0 rgba(0,0,0,0)', duration: 0.5, ease: 'power3.inOut' });
  };

  return (
    <div ref={formRef} className="w-full max-w-md">
      <div className="flex items-center mb-6">
        <button onClick={() => router.back()} className="mr-2 p-1 rounded hover:bg-gray-100 text-gray-600" aria-label="Quay lại">
          <ArrowLeft className="w-5 h-5" />
        </button>

        <div className="relative w-10 h-10 mr-2">
          <Image src="/images/brainbattle_logo_really_pink.png" alt="BrainBattle Logo" fill className="object-contain" priority />
        </div>
        <h1 className="text-2xl font-extrabold tracking-widest uppercase bg-gradient-to-r from-pink-500 via-pink-400 to-purple-400 text-transparent bg-clip-text">
          Brain Battle
        </h1>
      </div>

      <h2 className="text-lg font-medium text-gray-900 mb-2">Tạo tài khoản</h2>
      <p className="text-sm text-gray-500 mb-6">Nhập thông tin bên dưới để bắt đầu.</p>

      <form className="space-y-5" onSubmit={onSubmit}>
        <div>
          <label className="block text-sm text-gray-500 mb-1">Họ và tên</label>
          <GsapUnderlineField
            icon={UserRound}
            value={name}
            onChange={(e) => setName(e.target.value)}
            type="text"
            placeholder="Tên hiển thị"
            autoComplete="name"
          />
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Email</label>
          <GsapUnderlineField
            icon={Mail}
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            type="email"
            placeholder="Địa chỉ email"
            autoComplete="email"
          />
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Mật khẩu</label>
          <GsapUnderlineField
            icon={Lock}
            value={pass}
            onChange={(e) => setPass(e.target.value)}
            type={showPass ? 'text' : 'password'}
            placeholder="Mật khẩu"
            autoComplete="new-password"
            rightAdornment={
              <button
                type="button"
                onClick={() => setShowPass(v => !v)}
                className="p-1 text-gray-500 hover:text-gray-700"
                aria-label="Hiện/ẩn mật khẩu"
              >
                {showPass ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
              </button>
            }
          />
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Xác nhận mật khẩu</label>
          <GsapUnderlineField
            icon={Lock}
            value={confirm}
            onChange={(e) => setConfirm(e.target.value)}
            type={showPass ? 'text' : 'password'}
            placeholder="Nhập lại mật khẩu"
            autoComplete="new-password"
          />
        </div>

        {err && <p className="text-sm text-red-600">{err}</p>}
        {okMsg && (
          <p className="text-sm text-emerald-600 flex items-center gap-1">
            <CheckCircle2 className="w-4 h-4" /> {okMsg}
          </p>
        )}

        <button
          ref={ctaRef}
          type="submit"
          disabled={loading}
          onMouseEnter={onCtaEnter}
          onMouseLeave={onCtaLeave}
          className="relative overflow-hidden w-full rounded-full py-3 font-semibold text-white uppercase tracking-wider transition disabled:opacity-70 border border-white/30 bg-[linear-gradient(90deg,#f9a8d4,#f472b6,#c084fc)] bg-[length:200%_100%] bg-left"
          aria-busy={loading}
        >
          <div
            ref={shineRef}
            className="pointer-events-none absolute inset-y-0 -left-1/3 aspect-square rounded-full blur-md mix-blend-screen"
            style={{ background: 'radial-gradient(closest-side, rgba(255,255,255,.95), rgba(255,255,255,.35) 60%, rgba(255,255,255,0) 70%)' }}
          />
          <span className="relative z-10">{loading ? 'Đang tạo…' : 'Tạo tài khoản'}</span>
        </button>

        <p className="text-center text-sm text-gray-700">
          Đã có tài khoản? <GradientLink href="/sign-in">Đăng nhập</GradientLink>
        </p>
      </form>
    </div>
  );
}
