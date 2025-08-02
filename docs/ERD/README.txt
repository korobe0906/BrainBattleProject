Lộ trình từ ERD → Backend → REST API
Bước 1: Dựa vào ERD để tạo schema
Prisma (schema.prisma)  dễ dùng với NestJS
Bước 2: Tạo model + service: Với NestJS + Prisma:
npx prisma generate
nest g module users
nest g controller users
nest g service users
Bước 3: Viết các route REST API (CRUD)
Ví dụ với bảng users:
API	Method		Mô tả
/users		GET	Lấy danh sách user
/users/:id	GET	Lấy user theo ID
/users		POST	Tạo user mới
/users/:id	PUT	Cập nhật user
/users/:id	DELETE	Xoá user
→ Làm tương tự với:
lessons, quizzes, videos, battles, v.v.

src/
├── users/
│   ├── users.module.ts
│   ├── users.controller.ts   // REST API
│   ├── users.service.ts      // Gọi prisma
│   └── dto/                  // DTO: CreateUserDto, UpdateUserDto>shared(nếu chung)
├── lessons/
├── videos/
├── battles/
└── auth/

