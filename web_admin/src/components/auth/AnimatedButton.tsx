'use client';

import { useRef, useEffect } from 'react';
import { gsap } from 'gsap';

export default function AnimatedLoginButton() {
  const buttonRef = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    // Animation khi nút vừa mount
    gsap.fromTo(
      buttonRef.current,
      { scale: 0.9, opacity: 0, y: 20 },
      { scale: 1, opacity: 1, y: 0, duration: 1, ease: 'elastic.out(1, 0.5)' }
    );
  }, []);

  const handleHover = () => {
    gsap.to(buttonRef.current, {
      scale: 1.05,
      boxShadow: '0px 0px 16px #facc15',
      backgroundColor: '#facc15', // vàng tươi
      color: '#000',
      duration: 0.3,
    });
  };

  const handleLeave = () => {
    gsap.to(buttonRef.current, {
      scale: 1,
      boxShadow: '0px 0px 0px transparent',
      backgroundColor: '#FCD34D', // yellow-300
color: '#000',
      duration: 0.3,
    });
  };

  return (
    <button
      ref={buttonRef}
      type="submit"
      onMouseEnter={handleHover}
      onMouseLeave={handleLeave}
      className="w-full bg-yellow-300 text-black font-semibold py-2 px-4 rounded transition-all duration-200"

    >
      Đăng nhập
    </button>
  );
}
