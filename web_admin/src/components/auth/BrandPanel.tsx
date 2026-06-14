'use client';

import Lottie from 'lottie-react';
import frameLogoAnim from '@/../public/animations/animated_logo_realy_pink.json';

export default function BrandPanel() {
  return (
    <section
      className="relative hidden min-h-screen w-1/2 items-center justify-center overflow-hidden
      bg-gradient-to-br from-pink-200 via-pink-100 to-purple-200 lg:flex"
    >
      <div className="absolute inset-0">
        <div className="absolute inset-0 bg-[url('/images/london.jpg')] bg-cover bg-center brightness-110 contrast-110" />
        <div className="absolute inset-0 bg-gradient-to-br from-pink-200/70 to-purple-200/70" />
      </div>

      <div className="relative z-10 text-center">
        <div className="mb-4 flex justify-center">
          <div className="h-50 w-50">
            <Lottie animationData={frameLogoAnim} loop />
          </div>
        </div>

        <h2 className="bg-gradient-to-r from-pink-500 via-pink-400 to-purple-400 bg-clip-text text-3xl font-extrabold uppercase tracking-widest text-transparent drop-shadow-sm">
          Brain Battle
        </h2>

        <p className="mt-2 text-sm text-gray-700 opacity-90">
          Competitive language learning management system.
        </p>
      </div>
    </section>
  );
}