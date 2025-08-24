# BrainBattle – Admin Web (Next.js)

This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app). Stack: App Router, TypeScript, TailwindCSS.

## Requirements
- Node.js **>= 18.17** (khuyến nghị 20.x LTS)
- NPM/Yarn/PNPM/Bun (dùng NPM mặc định)

## Getting Started

### 1) Clone & vào đúng thư mục
```bash
git clone https://github.com/korobe0906/BrainBattleProject.git
cd BrainBattleProject/web_admin
```

### 2) Cài dependencies
```bash
# cài deps từ package.json
npm i
# đảm bảo các lib UI có mặt (nếu chưa có trong package.json)
npm i gsap lucide-react clsx tailwind-merge
# (tuỳ chọn theo code bạn dùng)
npm i @tanstack/react-table @radix-ui/react-dropdown-menu @radix-ui/react-dialog
```

### 3) Tạo biến môi trường (dev)
Tạo file .env.local (không commit):
```bash
# ví dụ dành cho DEV — không dùng cho production
ADMIN_EMAIL=admin@brainbattle.app
ADMIN_PASSWORD=admin123
```

### 4) Chạy development server
```bash
npm run dev
# or: yarn dev / pnpm dev / bun dev
```
Mở http://localhost:3000 để xem kết quả.
Bạn có thể bắt đầu chỉnh ở src/app/page.tsx hoặc các route trong src/app/.... Hot reload bật sẵn.
VD: http://localhost:3000/sign-in

## Script
```bash
npm run dev     # chạy dev
npm run build   # build production
npm run start   # chạy bản build đã build
npm run lint    # lint code
```

## Project Structure (tóm tắt)
```bash
web_admin/
├─ public/images/              # asset tĩnh; có .gitkeep
├─ src/
│  ├─ app/
│  │  ├─ sign-in/              # trang đăng nhập + GSAP
│  │  └─ admin/                # khu admin (overview, learners…)
│  ├─ components/              # header, sidebar, dashboard, learners, auth
│  ├─ lib/                     # utils (cn), types (user)
│  └─ styles/                  # globals.css (nếu tách)
├─ package.json  tsconfig.json  tailwind.config.ts  postcss.config.mjs  next.config.*
└─ .gitignore
```
## Notes
  - Import alias: @/* → trỏ src/* (cấu hình trong tsconfig.json).
  - Helper cn(...): dùng clsx + tailwind-merge trong src/lib/utils.ts.
  - GSAP chạy phía client: thêm 'use client' và gọi trong useEffect.
  - Không commit .env*; nếu cần, cung cấp .env.example.

## Learn More
  - Next.js Documentation – tính năng & API.
  - Learn Next.js – tutorial tương tác.
  - Next.js GitHub – issues/PRs welcome.
  
## Deploy on Vercel
Cách nhanh nhất là deploy trên Vercel.
Monorepo tip:
  - Root Directory: web_admin
  - Framework Preset: Next.js
  - Build/Output để mặc định.



