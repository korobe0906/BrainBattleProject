import type { Topic } from "@/types/clanGuild.types";

const randomId = () => Math.random().toString(36).substr(2, 9);
const randomInt = (min: number, max: number) => Math.floor(Math.random() * (max - min + 1)) + min;
const randomPick = <T,>(arr: T[]): T => arr[Math.floor(Math.random() * arr.length)];
const randomDate = (daysAgo: number) => {
  const date = new Date();
  date.setDate(date.getDate() - randomInt(0, daysAgo));
  return date.toISOString();
};

const topicsByCategory = {
  General: ["Welcome", "Introductions", "General Chat", "Off-Topic", "Announcements", "News", "Updates"],
  Language: ["English", "Spanish", "French", "German", "Chinese", "Japanese", "Korean", "Vietnamese", "Learning"],
  Game: ["Strategy", "PvP", "PvE", "Tournaments", "Events", "Rankings", "Guilds", "Trading", "Quests"],
  Study: ["Vocabulary", "Grammar", "Pronunciation", "Reading", "Writing", "Listening", "Speaking", "Practice"],
  Other: ["Feedback", "Suggestions", "Bug Reports", "Support", "Recruitment", "Marketplace", "Media"],
};

const synonymsByTopic: Record<string, string[]> = {
  "Welcome": ["Greetings", "Hello", "New Members"],
  "PvP": ["Player vs Player", "Competitive", "Arena"],
  "Strategy": ["Tactics", "Tips", "Guide"],
  "Trading": ["Exchange", "Marketplace", "Swap"],
  "Vocabulary": ["Words", "Lexicon", "Terms"],
};

export const mockTopics: Topic[] = [];

let topicIndex = 1;
Object.entries(topicsByCategory).forEach(([category, topics]) => {
  topics.forEach(topicName => {
    const id = randomId();
    const topicCode = `TOPIC-${String(topicIndex++).padStart(4, "0")}`;
    const usageCount = randomInt(0, 50);
    const createdAt = randomDate(180);
    const updatedAt = randomDate(30);

    // Status distribution: 85% Active, 10% Inactive, 5% Banned
    let status: "Active" | "Inactive" | "Banned";
    const rand = Math.random();
    if (rand < 0.85) status = "Active";
    else if (rand < 0.95) status = "Inactive";
    else status = "Banned";

    // 20% missing optional fields
    const hasOptional = Math.random() > 0.2;

    mockTopics.push({
      id,
      topicCode,
      name: topicName,
      category: category as "General" | "Language" | "Game" | "Study" | "Other",
      description: hasOptional ? `Discussion and content related to ${topicName.toLowerCase()}` : undefined,
      synonyms: hasOptional && synonymsByTopic[topicName] ? synonymsByTopic[topicName] : undefined,
      usageCount,
      status,
      createdAt,
      updatedAt,
    });
  });
});
