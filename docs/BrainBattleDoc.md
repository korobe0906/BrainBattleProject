# 📚 BrainBattle – Dự án Học Ngoại Ngữ Gamified

---

## I. 🎯 Giới thiệu

**BrainBattle** là một nền tảng học ngoại ngữ sáng tạo, kết hợp:
- 🌐 Trải nghiệm TikTok-style học phi tuyến tính
- 🧠 Học tuyến tính theo lộ trình AIM cá nhân hóa
- 🎮 Cơ chế chiến đấu kiến thức kiểu MOBA 1v1 / 5v5
- 🤖 Tích hợp AI (GPT + RAG), Blockchain (NFT), Camera/LiDAR

Dự án áp dụng mô hình microservice để dễ mở rộng, phát triển linh hoạt và scale production.

---

## II. 🏗 Kiến trúc hệ thống

- **Frontend**:
  - `Flutter` (Mobile)
  - `Next.js` (Web Client, Web Admin)
- **Backend**:
  - `Supabase` (Auth + DB + Realtime)
  - `FastAPI` (Business logic, AI Service)
  - `Socket.io` (Quiz Battle Realtime)
- **AI**:
  - `OpenAI API`, `RAG`, `Ontology Mapping`
- **Blockchain**:
  - `Polygon Mumbai Testnet`, `MetaMask`, `NFT Certificate`
- **Media**:
  - `Firebase Storage` (video/livestream)
- **DevOps**:
  - `Docker`, `GitHub Actions`, `Monorepo`

---

## III. 📁 Cấu trúc repo

```plaintext
brainbattle-monorepo/
├── apps/               # Frontend apps
│   ├── mobile/         # Flutter App
│   ├── web-client/     # Học viên (Next.js)
│   ├── web-admin/      # Admin (Next.js)
│
├── services/           # Microservices backend
│   ├── auth-service/       # Đăng nhập, phân quyền
│   ├── quiz-service/       # Battle quiz, câu hỏi
│   ├── user-service/       # AIM, tiến độ học
│   ├── content-service/    # Feed video, livestream
│   ├── ai-service/         # Gợi ý bài học, RAG
│   ├── nft-service/        # NFT chứng chỉ
│
├── shared/             # Tài nguyên dùng chung
│   ├── models/
│   ├── utils/
│   ├── config/
│
├── docs/               # Tài liệu hệ thống
│   ├── api-spec.md
│   ├── erd.drawio
│   ├── ai-flow.md
│
├── infra/              # CI/CD, DevOps
│   ├── docker-compose.yml
│   ├── .github/workflows/
│   ├── envs/
│
├── README.md
├── .gitignore
├── .env.example
IV. 🧩 Microservice Breakdown
Service	Chức năng
auth-service	Đăng nhập, xác thực JWT, phân quyền
quiz-service	Logic câu hỏi, tính điểm, battle
user-service	AIM cá nhân, tiến độ học tập
content-service	Feed video, livestream, hashtag
ai-service	Gợi ý học, liên kết nội dung tuyến tính + xã hội
nft-service	Cấp chứng chỉ NFT, trao quà blockchain

V. ⚙️ Thiết lập local development
1. Clone repo & khởi chạy
bash
Copy
Edit
git clone https://github.com/your-org/brainbattle-monorepo.git
cd brainbattle-monorepo
cp .env.example .env
docker-compose up --build
2. Cài Flutter (mobile)
bash
Copy
Edit
cd apps/mobile
flutter pub get
flutter run
3. Cài web client/admin
bash
Copy
Edit
cd apps/web-client  # hoặc web-admin
npm install
npm run dev
VI. 📌 Quy định làm việc nhóm
🧠 Vai trò:
Thành viên	Vai trò
@you	Leader – DB & Backend
...	Mobile Dev, Web Dev, AI, Media, QA...

💡 Quy ước:
Tên nhánh: feature/battle-quiz, fix/video-stream, ai/rag-pipeline

PR yêu cầu 1 reviewer → mới được merge

Gắn task vào Kanban

VII. 🔗 Tài liệu tham khảo
🎨 Figma thiết kế giao diện

🧠 Sơ đồ ERD CSDL

📜 Đặc tả API + use case

🧠 Luồng AI & RAG + Ontology

📦 Landing Page

VIII. 📬 Liên hệ nhóm phát triển
📧 Email nhóm: brainbattle.team@gmail.com

🌐 Fanpage: https://facebook.com/brainbattle

🗣️ Discord cộng đồng: https://discord.gg/brainbattle