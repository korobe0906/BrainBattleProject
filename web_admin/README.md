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

### 2) Cài dependencies
# cài deps từ package.json
npm i

# đảm bảo các lib UI có mặt (nếu chưa có trong package.json)
npm i gsap lucide-react clsx tailwind-merge
# (tuỳ chọn theo code bạn dùng)
npm i @tanstack/react-table @radix-ui/react-dropdown-menu @radix-ui/react-dialog
