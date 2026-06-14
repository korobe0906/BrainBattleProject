'use client';

import Image from 'next/image';
import { FormEvent, useEffect, useRef, useState } from 'react';
import { useRouter } from 'next/navigation';
import gsap from 'gsap';
import { Eye, EyeOff, Lock, Mail } from 'lucide-react';
import GsapUnderlineField from '@/components/gsap/GsapUnderlineField';
import GradientLink from '@/components/gsap/GradientLink';
import { signInAdmin } from '@/lib/api/admin-auth';

export default function SignInPage() {
  const router = useRouter();
  const [showPass, setShowPass] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const [loading, setLoading] = useState(false);
  const [err, setErr] = useState<string | null>(null);

  const formWrapRef = useRef<HTMLDivElement | null>(null);
  const ctaRef = useRef<HTMLButtonElement | null>(null);
  const shineRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    gsap.fromTo(
      formWrapRef.current,
      { y: 10, opacity: 0 },
      { y: 0, opacity: 1, duration: 0.45, ease: 'power3.out' },
    );
  }, []);

  const onCtaEnter = () => {
    const el = ctaRef.current;
    const shine = shineRef.current;
    if (!el || !shine) return;

    gsap.set(shine, { xPercent: -60, opacity: 0.9, scale: 0.95 });

    const tl = gsap.timeline({ defaults: { ease: 'power2.out' } });
    tl.to(el, { backgroundPosition: '100% 0%', duration: 0.8 }, 0)
      .to(shine, { xPercent: 160, scale: 1.05, duration: 0.8 }, 0)
      .to(
        el,
        { boxShadow: '0 0 20px rgba(236,72,153,.6)', duration: 0.3 },
        0,
      );
  };

  const onCtaLeave = () => {
    const el = ctaRef.current;
    if (!el) return;

    gsap.to(el, {
      backgroundPosition: '0% 0%',
      boxShadow: '0 0 0 rgba(0,0,0,0)',
      duration: 0.5,
      ease: 'power3.inOut',
    });
  };

  async function onSubmit(e: FormEvent) {
    e.preventDefault();
    if (loading) return;

    setErr(null);
    setLoading(true);

    try {
      await signInAdmin(email.trim(), password);
      router.replace('/admin');
    } catch (error) {
      setErr(error instanceof Error ? error.message : 'Sign in failed');
      gsap.fromTo(
        formWrapRef.current,
        { x: -6 },
        { x: 0, duration: 0.25, ease: 'elastic.out(1,0.6)' },
      );
    } finally {
      setLoading(false);
    }
  }

  return (
    <div ref={formWrapRef}>
      <div className="mb-6 flex items-center">
        <div className="relative mr-2 h-10 w-10">
          <Image
            src="/images/brainbattle_logo_really_pink.png"
            alt="BrainBattle Logo"
            fill
            className="object-contain"
            priority
          />
        </div>

        <h1 className="bg-gradient-to-r from-pink-500 via-pink-400 to-purple-400 bg-clip-text text-2xl font-extrabold uppercase tracking-widest text-transparent">
          Brain Battle
        </h1>
      </div>

      <p className="mb-6 text-sm text-gray-500">
        Sign in with a real Supabase admin account.
      </p>

      <form className="space-y-5" onSubmit={onSubmit}>
        <div>
          <label className="mb-1 block text-sm text-gray-500">Email</label>
          <GsapUnderlineField
            icon={Mail}
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            type="email"
            placeholder="admin@brainbattle.app"
            autoComplete="username"
            aria-invalid={!!err}
          />
        </div>

        <div>
          <label className="mb-1 block text-sm text-gray-500">Password</label>
          <GsapUnderlineField
            icon={Lock}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            type={showPass ? 'text' : 'password'}
            placeholder="Enter password"
            autoComplete="current-password"
            rightAdornment={
              <button
                type="button"
                onClick={() => setShowPass((v) => !v)}
                className="p-1 text-gray-500 hover:text-gray-700"
                aria-label="Toggle password"
              >
                {showPass ? (
                  <EyeOff className="h-4 w-4" />
                ) : (
                  <Eye className="h-4 w-4" />
                )}
              </button>
            }
          />
        </div>

        {err && <p className="text-sm font-semibold text-red-600">{err}</p>}

        <button
          ref={ctaRef}
          type="submit"
          disabled={loading}
          onMouseEnter={onCtaEnter}
          onMouseLeave={onCtaLeave}
          className="
            relative w-full overflow-hidden rounded-full border border-white/30
            bg-[linear-gradient(90deg,#f9a8d4,#f472b6,#c084fc)]
            bg-[length:200%_100%] bg-left py-3 font-semibold
            uppercase tracking-wider text-white transition disabled:opacity-70
          "
          aria-busy={loading}
        >
          <div
            ref={shineRef}
            className="pointer-events-none absolute inset-y-0 -left-1/3 aspect-square rounded-full blur-md mix-blend-screen"
            style={{
              background:
                'radial-gradient(closest-side, rgba(255,255,255,.95), rgba(255,255,255,.35) 60%, rgba(255,255,255,0) 70%)',
            }}
          />
          <span className="relative z-10">
            {loading ? 'Signing in...' : 'Sign In'}
          </span>
        </button>

        <p className="text-center text-sm text-gray-700">
          Forgot password? <GradientLink href="/sign-in/forgot">Recover</GradientLink>
        </p>
      </form>
    </div>
  );
}