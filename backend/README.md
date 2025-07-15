
1. Tổng thể cây thư mục cho backend:
/backend
│
├── src/
│   ├── main.ts
│   ├── app.module.ts
│
│   ├── config/                # Cấu hình: Supabase, Socket.IO, AI, JWT, etc.
│   │   ├── supabase.config.ts
│   │   ├── socket.config.ts
│   │   ├── auth.config.ts
│   │   └── ...
│
│   ├── common/                # Mã dùng chung: filter, guard, decorator, pipes
│   │   ├── guards/
│   │   ├── interceptors/
│   │   ├── exceptions/
│   │   ├── decorators/
│   │   └── utils/
│
│   ├── core/                  # Giao tiếp với Supabase (PostgreSQL + Auth + Storage)
│   │   ├── supabase-client.ts
│   │   ├── auth.service.ts
│   │   ├── db.service.ts
│   │   └── storage.service.ts
│
│   ├── modules/               # Chia theo domain logic, phục vụ cả 3 frontend
│   │   ├── auth/              # Đăng ký, đăng nhập, xác thực token Supabase
│   │   ├── users/             # Hồ sơ người dùng, vai trò
│   │   ├── lessons/           # Bài học tuyến tính, phân cấp unit
│   │   ├── exercises/         # Trắc nghiệm, bài tập đa dạng
│   │   ├── aim/               # Lộ trình cá nhân hóa
│   │   ├── videos/            # Feed video (TikTok-style), upload, livestream
│   │   ├── interactions/      # Like, comment, follow, quà tặng
│   │   ├── battle/            # Thi đấu 1v1, 5v5 (realtime)
│   │   ├── clan/              # Nhóm học tập, chat nhóm
│   │   ├── admin/             # Dành riêng WebAdmin: kiểm duyệt, báo cáo, dashboard
│   │   ├── creator/           # Creator upload bài học/video, livestream
│   │   ├── recommendation/    # AI: đề xuất video học
│   │   ├── moderation/        # AI kiểm duyệt nội dung
│   │   ├── blockchain/        # NFT chứng chỉ, giao dịch
│   │   ├── ai-gateway/        # Giao tiếp AI Service (FastAPI)
│   │   └── notification/      # Push notification, email nhắc học
│
│   ├── gateway/               # Socket.IO Gateway cho Battle & Clan
│   │   ├── battle.gateway.ts
│   │   └── clan.gateway.ts
│
│   ├── routes/                # Routing rõ ràng theo client
│   │   ├── mobile.routes.ts
│   │   ├── webadmin.routes.ts
│   │   └── webclient.routes.ts
│
│   ├── permissions/           # Role-based access control (Học viên / Creator / Admin)
│   │   └── ability.factory.ts
│
│   └── app.controller.ts      # Test route hoặc public API
│
├── prisma/                    # Schema + migration (nếu có dùng Prisma ngoài Supabase)
│   ├── schema.prisma
│   └── seed.ts
│
├── test/                      # Unit / e2e tests
├── .env
├── .env.production
├── Dockerfile
├── docker-compose.yml
└── README.md

3. Lệnh cài đặt ban đầu
Nestjs:
cd backend
npx nest new .
# Chọn npm hoặc yarn
Cài thêm Supabase SDK:
npm install @supabase/supabase-js
Create .env file:
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_KEY=your-anon-or-service-role-key
PORT=3000
Install dependencies:
npm install
Start dev server:
npm run start:dev