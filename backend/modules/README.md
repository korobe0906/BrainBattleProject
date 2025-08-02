modules/
├── duolingo/
│   ├── units/
│   ├── lessons/
│   ├── quizzes/
│   └── progress/
├── tiktok/
│   ├── videos/
│   ├── comments/
│   └── likes/
├── battle/
│   ├── battles/
│   ├── questions/
│   └── results/
├── clan/
│   ├── clans/
│   └── chats/

--> Lưu ý:
-Trong mỗi module backend (auth, users, lessons, v.v.), chỉ nên khai báo DTO/tệp mới nếu nó không dùng chung.

-Nếu DTO đó là public API format → chuyển qua shared/dto/ để frontend dùng chung.

-Một module trong backend có thể phục vụ nhiều actor (vai trò người dùng), nhưng mỗi actor sẽ chỉ được truy cập và thực hiện các chức năng khác nhau dựa trên vai trò (role) và phân quyền (permissions).

Ví dụ rõ ràng:
Module users
Admin:  GET /users: xem tất cả người dùng

        PATCH /users/:id: cập nhật trạng thái user (ban, unban)

        DELETE /users/:id: xóa user

Learner / Creator:  GET /users/me: xem thông tin cá nhân

                    PATCH /users/me: cập nhật thông tin cá nhân

Tất cả cùng dùng users.controller.ts, nhưng phân biệt qua @Roles() và req.user.id.

Module report
Learner: POST /reports: gửi report (vi phạm nội dung, lỗi…)

Admin:  GET /reports: xem tất cả report

        PATCH /reports/:id: xử lý report

Làm được điều này nhờ:
Guard phân quyền
Dùng @UseGuards(RoleGuard) để kiểm tra vai trò người dùng.

Decorator @Roles()
Gắn trên mỗi route để chỉ cho phép actor tương ứng.

req.user.role để xử lý logic bên trong nếu cần.

