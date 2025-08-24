import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

async function main() {
  await prisma.role.createMany({
    data: [
      { name: 'ADMIN' },
      { name: 'USER' },
      { name: 'CREATOR' },
    ],
    skipDuplicates: true,
  });
}
main();
    