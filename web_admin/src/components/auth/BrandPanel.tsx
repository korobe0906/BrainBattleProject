'use client';

import Lottie from 'lottie-react';
import frameLogoAnim from '@/../public/animations/animated_logo_realy_pink.json';

export default function BrandPanel() {
  return (
    <section
      className="hidden lg:flex w-1/2 min-h-screen relative items-center justify-center
                 bg-gradient-to-br from-pink-200 via-pink-100 to-purple-200"
    >
      {/* Background overlay (ảnh + gradient mờ) */}
      <div className="absolute inset-0">
        <div className="absolute inset-0 bg-[url('/images/london.jpg')] bg-cover bg-center brightness-110 contrast-110" />
        <div className="absolute inset-0 bg-gradient-to-br from-pink-200/70 to-purple-200/70" />
      </div>

      {/* Content */}
      <div className="relative z-10 text-center">
        {/* Lottie logo */}
        <div className="flex justify-center mb-4">
          <div className="w-50 h-50">
            <Lottie animationData={frameLogoAnim} loop={true} />
          </div>
        </div>

        {/* Brand title */}
        <h2
          className="text-3xl font-extrabold uppercase tracking-widest
                     bg-gradient-to-r from-pink-500 via-pink-400 to-purple-400
                     text-transparent bg-clip-text drop-shadow-sm"
        >
          Brain Battle
        </h2>

        {/* Subtitle */}
        <p className="text-gray-700 text-sm mt-2 opacity-90">
          Nền tảng học tiếng Anh giao tiếp, vui như game!
        </p>
      </div>
    </section>
  );
}
