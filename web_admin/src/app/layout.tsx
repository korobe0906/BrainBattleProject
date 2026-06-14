import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
// @ts-ignore: allow importing global CSS without type declarations
import '../styles/globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: 'BrainBattle Admin',
  description: 'BrainBattle Administration Console',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="vi" suppressHydrationWarning>
      <body className={inter.className}>{children}</body>
    </html>
  );
}