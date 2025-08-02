backend/
├── common/              ← DTO, pipes, helpers dùng chung
├── config/              ← Cấu hình (env, db, constants…)
├── core/                ← Auth, user, role (nền tảng hệ thống)
├── gateway/             ← Có thể dùng cho websocket (Battle/chat)
├── modules/             ← CHUẨN! Nơi chứa các tính năng theo domain
├── permissions/         ← Có thể là RBAC hoặc policy guard
├── prisma/              ← ORM layer, schema.prisma
├── routes/              ← Có thể là tập hợp route tổng hợp
├── storage/             ← Firebase/Supabase Storage upload
├── supabase/            ← Supabase client/init
├── test/                ← Test case
├── .env / .env.production
├── docker-compose.yml
├── Dockerfile
└── README.md
--> Tổ chức theo hướng clean architecture và modular backend.