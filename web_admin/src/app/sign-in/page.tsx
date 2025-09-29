'use client';

import Image from 'next/image';
import { useEffect, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import gsap from 'gsap';
import { Mail, Lock, Eye, EyeOff } from 'lucide-react';
import GsapUnderlineField from '@/components/gsap/GsapUnderlineField';
import GradientLink from '@/components/gsap/GradientLink';

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
  const shineRef = useRef<HTMLDivElement>(null);
  const rememberWrapRef = useRef<HTMLLabelElement>(null);

  useEffect(() => {
    gsap.fromTo(
      formWrapRef.current,
      { y: 10, opacity: 0 },
      { y: 0, opacity: 1, duration: 0.45, ease: 'power3.out' }
    );
  }, []);

  // CTA hover: gradient sweep + shine
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
    gsap.to(el, {
      backgroundPosition: '0% 0%',
      boxShadow: '0 0 0 rgba(0,0,0,0)',
      duration: 0.5, ease: 'power3.inOut'
    });
  };

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
      {/* Header */}
      <div className="flex items-center mb-6">
        <div className="relative w-10 h-10 mr-2">
          <Image src="/images/brainbattle_logo_really_pink.png" alt="BrainBattle Logo" fill className="object-contain" priority />
        </div>
        <h1 className="text-2xl font-extrabold tracking-widest uppercase bg-gradient-to-r from-pink-500 via-pink-400 to-purple-400 text-transparent bg-clip-text">
          Brain Battle
        </h1>
      </div>

      <p className="text-sm text-gray-500 mb-6">Đăng nhập để tiếp tục</p>

      <form className="space-y-5" onSubmit={onSubmit}>
        <div>
          <label className="block text-sm text-gray-500 mb-1">Tài khoản</label>
          <GsapUnderlineField
            icon={Mail}
            value={username}
            onChange={e => setUsername(e.target.value)}
            type="text"
            placeholder="Email hoặc username"
            autoComplete="username"
            aria-invalid={!!err}
          />
        </div>

        <div>
          <label className="block text-sm text-gray-500 mb-1">Mật khẩu</label>
          <GsapUnderlineField
            icon={Lock}
            value={password}
            onChange={e => setPassword(e.target.value)}
            type={showPass ? 'text' : 'password'}
            placeholder="Nhập mật khẩu"
            autoComplete="current-password"
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

        {err && <p className="text-sm text-red-600">{err}</p>}

        <div className="flex justify-between items-center text-sm text-gray-600">
          <label
            ref={rememberWrapRef}
            onMouseEnter={() => gsap.to(rememberWrapRef.current, { scale: 1.03, duration: 0.2, ease: 'power2.out' })}
            onMouseLeave={() => gsap.to(rememberWrapRef.current, { scale: 1, duration: 0.2, ease: 'power2.out' })}
            className="flex items-center gap-2 cursor-pointer"
          >
            <input
              type="checkbox"
              checked={remember}
              onChange={e => setRemember(e.target.checked)}
              className="accent-pink-500 h-4 w-4"
            />
            <span className="text-gray-700">Ghi nhớ đăng nhập</span>
          </label>

          <GradientLink href="/sign-in/forgot">Quên mật khẩu?</GradientLink>
        </div>

        <button
          ref={ctaRef}
          type="submit"
          disabled={loading}
          onMouseEnter={onCtaEnter}
          onMouseLeave={onCtaLeave}
          className="
            relative overflow-hidden w-full rounded-full py-3 font-semibold
            text-white uppercase tracking-wider transition disabled:opacity-70
            border border-white/30
            bg-[linear-gradient(90deg,#f9a8d4,#f472b6,#c084fc)]
            bg-[length:200%_100%] bg-left
          "
          aria-busy={loading}
        >
          <div
            ref={shineRef}
            className="pointer-events-none absolute inset-y-0 -left-1/3 aspect-square rounded-full blur-md mix-blend-screen"
            style={{ background: 'radial-gradient(closest-side, rgba(255,255,255,.95), rgba(255,255,255,.35) 60%, rgba(255,255,255,0) 70%)' }}
          />
          <span className="relative z-10">{loading ? 'Đang xử lý…' : 'Đăng nhập'}</span>
        </button>

        <p className="text-sm text-center text-gray-700">
          Chưa có tài khoản? <GradientLink href="/sign-in/signup">Đăng ký</GradientLink>
        </p>
      </form>
    </div>
  );
}
