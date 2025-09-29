'use client';

import { useRef } from 'react';
import gsap from 'gsap';

type IconType = React.ComponentType<React.SVGProps<SVGSVGElement>>;

function useUnderlineGsap() {
  const barRef = useRef<HTMLSpanElement>(null);
  const focused = useRef(false);

  const setScale = (s: number, opts: gsap.TweenVars = {}) =>
    gsap.to(barRef.current, { scaleX: s, duration: 0.35, ease: 'power3.out', ...opts });

  const onEnter = () => { if (!focused.current) setScale(0.6); };
  const onLeave = () => { if (!focused.current) setScale(0); };
  const onFocus = () => { focused.current = true; setScale(1); };
  const onBlur  = () => { focused.current = false; setScale(0); };

  return { barRef, onEnter, onLeave, onFocus, onBlur };
}

export default function GsapUnderlineField({
  icon: Icon,
  rightAdornment,
  className,
  ...props
}: React.InputHTMLAttributes<HTMLInputElement> & {
  icon?: IconType;
  rightAdornment?: React.ReactNode;
}) {
  const { barRef, onEnter, onLeave, onFocus, onBlur } = useUnderlineGsap();

  return (
    <div className="relative">
      <div
        className="flex items-center gap-2 border-b border-gray-300 focus-within:border-transparent"
        onMouseEnter={onEnter}
        onMouseLeave={onLeave}
      >
        {Icon && <Icon className="w-4 h-4 text-gray-400" />}
        <input
          {...props}
          onFocus={(e) => { onFocus(); props.onFocus?.(e); }}
          onBlur={(e) => { onBlur(); props.onBlur?.(e); }}
          className={`w-full py-2 bg-transparent outline-none placeholder:text-gray-500 text-gray-800 ${className ?? ''}`}
        />
        {rightAdornment}
      </div>

      {/* underline chạy ở đáy */}
      <span
        ref={barRef}
        className="pointer-events-none absolute left-0 right-0 -bottom-[1px] h-[2px]
                   bg-gradient-to-r from-pink-400 via-pink-500 to-purple-400
                   origin-left scale-x-0"
      />
    </div>
  );
}
