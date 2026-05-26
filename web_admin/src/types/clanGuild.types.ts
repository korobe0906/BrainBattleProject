// Clan/Guild Types and Enums

// ============== ENUMS ==============

export type ClanStatus = "Active" | "Inactive" | "Suspended";
export type ClanPrivacy = "Public" | "Private" | "Invite-only";
export type MemberRole = "Leader" | "Officer" | "Member";
export type MessageType = "Text" | "Image" | "Link" | "System";
export type MessageStatus = "Normal" | "Flagged" | "Hidden" | "Deleted";
export type BlockReason = "Spam" | "Fraud" | "Toxicity" | "Abuse" | "Other";
export type BlockDuration = "Temporary" | "Permanent";
export type TopicCategory = "General" | "Language" | "Game" | "Study" | "Other";
export type TopicStatus = "Active" | "Inactive" | "Banned";

export const CLAN_STATUSES: ClanStatus[] = ["Active", "Inactive", "Suspended"];
export const CLAN_PRIVACY_OPTIONS: ClanPrivacy[] = ["Public", "Private", "Invite-only"];
export const MEMBER_ROLES: MemberRole[] = ["Leader", "Officer", "Member"];
export const MESSAGE_TYPES: MessageType[] = ["Text", "Image", "Link", "System"];
export const MESSAGE_STATUSES: MessageStatus[] = ["Normal", "Flagged", "Hidden", "Deleted"];
export const BLOCK_REASONS: BlockReason[] = ["Spam", "Fraud", "Toxicity", "Abuse", "Other"];
export const BLOCK_DURATIONS: BlockDuration[] = ["Temporary", "Permanent"];
export const TOPIC_CATEGORIES: TopicCategory[] = ["General", "Language", "Game", "Study", "Other"];
export const TOPIC_STATUSES: TopicStatus[] = ["Active", "Inactive", "Banned"];

// ============== INTERFACES ==============

export interface Clan {
  id: string;
  clanCode: string;
  name: string;
  description?: string;
  leaderId: string;
  leaderName: string;
  membersCount: number;
  maxMembers: number;
  language: string;
  region: string;
  levelRequirement: number;
  privacy: ClanPrivacy;
  joinApproval: "Auto" | "Manual";
  status: ClanStatus;
  bannerUrl?: string;
  avatarUrl?: string;
  tags: string[];
  weeklyMessages: number;
  weeklyBattles?: number;
  reportsCount?: number;
  createdAt: string;
  lastActiveAt: string;
}

export interface ClanMember {
  id: string;
  clanId: string;
  clanName: string;
  userId: string;
  userName: string;
  role: MemberRole;
  level: number;
  contributionPoints: number;
  joinedAt: string;
  lastActiveAt: string;
}

export interface ChatMessage {
  id: string;
  messageId: string;
  clanId: string;
  clanName: string;
  clanCode: string;
  senderId: string;
  senderName: string;
  senderRole: MemberRole;
  messageType: MessageType;
  messagePreview: string;
  fullMessage: string;
  attachmentUrl?: string;
  flagsCount: number;
  flagReason?: "Spam" | "Toxicity" | "Harassment" | "Scam";
  status: MessageStatus;
  sentAt: string;
  moderatedBy?: string;
  moderatedAt?: string;
}

export interface BlockedClan {
  id: string;
  clanId: string;
  clanCode: string;
  clanName: string;
  reason: BlockReason;
  note?: string;
  blockedBy: string;
  blockedAt: string;
  expiresAt?: string;
  duration: BlockDuration;
  status: "Blocked";
}

export interface Topic {
  id: string;
  topicCode: string;
  name: string;
  category: TopicCategory;
  description?: string;
  synonyms?: string[];
  usageCount: number;
  status: TopicStatus;
  createdAt: string;
  updatedAt: string;
}

export interface ModerationLog {
  id: string;
  messageId: string;
  action: "Hide" | "Delete" | "Warn" | "Restore";
  reason: string;
  moderatorId: string;
  moderatorName: string;
  timestamp: string;
}
