// dto/register.dto.ts
import { IsEmail, IsNotEmpty, MinLength } from 'class-validator';

export class RegisterDto {
  @IsEmail()
  email: string;

  @MinLength(6)
  password: string;

  @IsNotEmpty()
  fullName: string;

  @IsNotEmpty()
  role: 'LEARNER' | 'CREATOR' | 'ADMIN'; // hoặc string nếu dùng enum từ db
}
