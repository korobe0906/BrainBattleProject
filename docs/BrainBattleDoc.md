📚 BrainBattle – Gamified Language Learning Platform
I. 🎯 Introduction
BrainBattle is an innovative language learning platform that combines:

🌐 TikTok-style nonlinear learning experience

🧠 Personalized linear learning paths based on AIM (Atomic Instructional Modules)

🎮 MOBA-style knowledge battles (1v1 / 5v5)

🤖 Integration with AI (GPT + RAG), Blockchain (NFT), and Camera/LiDAR

The project is built on a microservice architecture, enabling scalability, modular development, and smooth production deployment.

II. 🏗 System Architecture
Frontend:

Flutter (Mobile App)

Next.js (Web Client, Web Admin, Main App)

Backend:

Supabase (Authentication, Database, Realtime)

FastAPI (Business Logic, AI Services)

Socket.io (Real-time Quiz Battles)

AI:

OpenAI API, Retrieval-Augmented Generation (RAG), Ontology Mapping

Blockchain:

Polygon Mumbai Testnet, MetaMask, NFT-based Certificates

Media:

Firebase Storage (Video and Livestream Content)

DevOps:

Docker, GitHub Actions, Monorepo project structure

III. 📁 Repository Structure

plaintext
BrainBattleProject/
├── nestjs/                  # NestJS API
│   ├── src/
│   ├── modules/
│   ├── core/
│   ├── config/
│   ├── gateway/
│   ├── main.ts
│   ├── app.module.ts
│   └── ...
├── mobile-app/              # Flutter app
│   └── ...
├── web-admin/               # Next.js admin site
│   └── ...
├── web-client/              # Next.js user site
│   └── ...
├── ai-service/              # AI module (Python or TS)
│   └── ...
├── shared/                  # Tài nguyên dùng chung (type, schema)
│   └── ...
├── docs/                    # Tài liệu dự án, sơ đồ kiến trúc
│   └── overview.md
├── .github/
│   └── workflows/           # GitHub Actions (CI/CD)
│       └── deploy.yml
├── .gitignore
├── docker-compose.yml
├── README.md
└── LICENSE

IV. ⚙️ Local Development Setup
Clone the repository and run:
git clone https://github.com/korobe0906/BrainBattleProject.git

V. 🧑‍💻 Team Members
Member	Role
@PhamThiKieuDiem	Leader
@NguyenTruongNgocHan	

VI. 🚧 Development Guidelines
Branch Naming Conventions:

feature/battle-quiz

fix/video-stream

ai/rag-pipeline

Pull Request Rules:

Each PR must be reviewed by at least one reviewer before merging

Task Management:

All work should be linked to tasks on the Kanban board

VII. 📬 Contact the Development Team
📧 Email: laptrinh0906.@gmail.com

🌐 Facebook Fanpage: https://facebook.com/brainbattle

🗣️ Community Discord: https://discord.gg/brainbattle
