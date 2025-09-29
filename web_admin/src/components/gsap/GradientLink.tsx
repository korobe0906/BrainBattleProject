'use client';

import Link from 'next/link';
import { useRef } from 'react';
import gsap from 'gsap';

export default function GradientLink({
  href, children, className = '',
}: { href: string; children: React.ReactNode; className?: string }) {
  const aRef = useRef<HTMLAnchorElement>(null);
  const barRef = useRef<HTMLSpanElement>(null);

  const onEnter = () => {
    if (!aRef.current || !barRef.current) return;
    gsap.to(aRef.current, { y: -1, duration: 0.2, ease: 'power2.out' });
    gsap.to(barRef.current, { scaleX: 1, duration: 0.35, ease: 'power3.out' });
  };
  const onLeave = () => {
    if (!aRef.current || !barRef.current) return;
    gsap.to(aRef.current, { y: 0, duration: 0.2, ease: 'power2.out' });
    gsap.to(barRef.current, { scaleX: 0, duration: 0.35, ease: 'power3.in' });
  };

  return (
    <Link
      href={href}
      ref={aRef}
      onMouseEnter={onEnter}
      onMouseLeave={onLeave}
      className={`relative inline-block bg-gradient-to-r from-pink-400 to-purple-400
                  bg-clip-text text-transparent font-semibold ${className}`}
    >
      {children}
      <span
        ref={barRef}
        className="absolute left-0 -bottom-0.5 h-[2px] w-full origin-left scale-x-0 
                   bg-gradient-to-r from-pink-400 to-purple-400"
      />
    </Link>
  );
}
