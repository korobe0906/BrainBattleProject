import type { BlockedClan } from "@/types/clanGuild.types";
import { mockClans } from "./clans.mock";

const randomId = () => Math.random().toString(36).substr(2, 9);
const randomInt = (min: number, max: number) => Math.floor(Math.random() * (max - min + 1)) + min;
const randomPick = <T,>(arr: T[]): T => arr[Math.floor(Math.random() * arr.length)];
const randomDate = (daysAgo: number) => {
  const date = new Date();
  date.setDate(date.getDate() - randomInt(0, daysAgo));
  return date.toISOString();
};

const adminNames = ["Admin John", "Admin Sarah", "Admin Mike", "Admin Lisa", "Moderator Tom"];

const reasonNotes = {
  Spam: [
    "Excessive promotional messages and advertisements",
    "Bot-like behavior flooding chat with repeated messages",
    "Unsolicited mass messaging to members",
  ],
  Fraud: [
    "Phishing attempts targeting clan members",
    "Fake giveaway scams reported by multiple users",
    "Account selling and RMT violations",
  ],
  Toxicity: [
    "Persistent harassment of clan members",
    "Hate speech and discriminatory language",
    "Creating hostile environment for players",
  ],
  Abuse: [
    "Exploiting game mechanics for unfair advantages",
    "Coordinated griefing of other clans",
    "Severe violation of community guidelines",
  ],
  Other: [
    "Multiple policy violations across different categories",
    "Unresponsive to warnings and moderation attempts",
    "Clan used for prohibited activities",
  ],
};

export const mockBlockedClans: BlockedClan[] = Array.from({ length: 20 }, (_, i) => {
  const id = randomId();
  const clan = mockClans[i % mockClans.length];
  const reason = randomPick<"Spam" | "Fraud" | "Toxicity" | "Abuse" | "Other">(["Spam", "Fraud", "Toxicity", "Abuse", "Other"]);
  const blockedBy = randomPick(adminNames);
  const blockedAt = randomDate(60);

  // Duration: 60% Temporary, 40% Permanent
  const duration = Math.random() < 0.6 ? "Temporary" : "Permanent";
  
  let expiresAt: string | undefined;
  if (duration === "Temporary") {
    const expiryDate = new Date(blockedAt);
    const daysToAdd = randomPick([7, 14, 30]);
    expiryDate.setDate(expiryDate.getDate() + daysToAdd);
    expiresAt = expiryDate.toISOString();
  }

  // 20% missing note
  const hasNote = Math.random() > 0.2;

  return {
    id,
    clanId: clan.id,
    clanCode: clan.clanCode,
    clanName: clan.name,
    reason,
    note: hasNote ? randomPick(reasonNotes[reason]) : undefined,
    blockedBy,
    blockedAt,
    expiresAt,
    duration: duration as "Temporary" | "Permanent",
    status: "Blocked",
  };
});
