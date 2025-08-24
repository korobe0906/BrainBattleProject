'use client';

import Image from 'next/image';

export default function BrandPanel() {
  return (
    <section className="hidden lg:flex w-1/2 min-h-screen bg-yellow-400 relative items-center justify-center">
      <div className="absolute inset-0">
        <div className="absolute inset-0 bg-[url('/images/london.jpg')] bg-cover bg-center brightness-110 contrast-110" />
        <div className="absolute inset-0 bg-yellow-400 opacity-70" />
      </div>

      <div className="relative z-10 text-center">
        <div className="flex justify-center mb-4">
          <div className="relative w-20 h-20 rotate-315">
            <Image src="/images/frame_logo.png" alt="BrainBattle Logo" fill className="object-contain" priority />
            <div className="absolute inset-0 flex items-center justify-center text-white text-3xl font-extrabold">B</div>
          </div>
        </div>
        <h2 className="text-3xl font-extrabold text-black drop-shadow">BrainBattle</h2>
        <p className="text-black text-sm mt-2 opacity-90">
          Nền tảng học tiếng Anh giao tiếp, vui như game!
        </p>
      </div>
    </section>
  );
}
