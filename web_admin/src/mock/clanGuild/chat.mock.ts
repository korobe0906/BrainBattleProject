import type { ChatMessage } from "@/types/clanGuild.types";
import { mockClans } from "./clans.mock";

const randomId = () => Math.random().toString(36).substr(2, 9);
const randomInt = (min: number, max: number) => Math.floor(Math.random() * (max - min + 1)) + min;
const randomPick = <T,>(arr: T[]): T => arr[Math.floor(Math.random() * arr.length)];
const randomDate = (daysAgo: number) => {
  const date = new Date();
  date.setDate(date.getDate() - randomInt(0, daysAgo));
  return date.toISOString();
};

const senderNames = [
  "Alice Cooper", "Bob Dylan", "Charlie Brown", "Diana Prince", "Edward Norton",
  "Fiona Apple", "George Lucas", "Helen Hunt", "Ian McKellen", "Julia Roberts",
  "Kevin Spacey", "Laura Dern", "Michael Jordan", "Nancy Drew", "Oscar Wilde",
  "Patricia Arquette", "Quincy Jones", "Rachel Green", "Steven Spielberg", "Tina Turner"
];

const messageTemplates = [
  "Hey everyone! Ready for tonight's battle?",
  "Great job in the last tournament!",
  "Anyone want to team up for quests?",
  "Check out this new strategy I found",
  "Welcome to our new members!",
  "Don't forget about the clan meeting tomorrow",
  "Looking for advice on this level",
  "Congratulations to our top contributors this week!",
  "Please remember our clan rules",
  "Who's online right now?",
  "This is spam content buy now click here",
  "Toxic message attacking other members",
  "Harassing inappropriate content",
  "Scam link don't click suspicious",
];

export const mockChatMessages: ChatMessage[] = Array.from({ length: 120 }, (_, i) => {
  const id = randomId();
  const messageId = `MSG-${String(i + 1).padStart(5, "0")}`;
  const clan = randomPick(mockClans);
  const senderId = randomId();
  const senderName = randomPick(senderNames);
  const senderRole = randomPick<"Leader" | "Officer" | "Member">(["Leader", "Officer", "Member"]);
  const messageType = randomPick<"Text" | "Image" | "Link" | "System">(["Text", "Image", "Link", "System"]);
  const fullMessage = randomPick(messageTemplates);
  const messagePreview = fullMessage.substring(0, 50) + (fullMessage.length > 50 ? "..." : "");
  const sentAt = randomDate(30);

  // Status distribution: 80% Normal, 10% Flagged, 7% Hidden, 3% Deleted
  let status: "Normal" | "Flagged" | "Hidden" | "Deleted";
  let flagsCount = 0;
  let flagReason: "Spam" | "Toxicity" | "Harassment" | "Scam" | undefined;
  let moderatedBy: string | undefined;
  let moderatedAt: string | undefined;

  const rand = Math.random();
  if (rand < 0.8) {
    status = "Normal";
  } else if (rand < 0.9) {
    status = "Flagged";
    flagsCount = randomInt(1, 5);
    flagReason = randomPick<"Spam" | "Toxicity" | "Harassment" | "Scam">(["Spam", "Toxicity", "Harassment", "Scam"]);
  } else if (rand < 0.97) {
    status = "Hidden";
    flagsCount = randomInt(1, 3);
    flagReason = randomPick<"Spam" | "Toxicity" | "Harassment" | "Scam">(["Spam", "Toxicity", "Harassment", "Scam"]);
    moderatedBy = "Admin";
    moderatedAt = randomDate(7);
  } else {
    status = "Deleted";
    flagsCount = randomInt(2, 8);
    flagReason = randomPick<"Spam" | "Toxicity" | "Harassment" | "Scam">(["Spam", "Toxicity", "Harassment", "Scam"]);
    moderatedBy = "Admin";
    moderatedAt = randomDate(7);
  }

  const hasAttachment = messageType === "Image" && Math.random() > 0.5;

  return {
    id,
    messageId,
    clanId: clan.id,
    clanName: clan.name,
    clanCode: clan.clanCode,
    senderId,
    senderName,
    senderRole,
    messageType,
    messagePreview,
    fullMessage,
    attachmentUrl: hasAttachment ? `https://picsum.photos/seed/${id}/400/300` : undefined,
    flagsCount,
    flagReason,
    status,
    sentAt,
    moderatedBy,
    moderatedAt,
  };
});
