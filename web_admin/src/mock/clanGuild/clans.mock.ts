import type { Clan } from "@/types/clanGuild.types";

// Helper functions
const randomId = () => Math.random().toString(36).substr(2, 9);
const randomInt = (min: number, max: number) => Math.floor(Math.random() * (max - min + 1)) + min;
const randomPick = <T,>(arr: T[]): T => arr[Math.floor(Math.random() * arr.length)];
const randomDate = (daysAgo: number) => {
  const date = new Date();
  date.setDate(date.getDate() - randomInt(0, daysAgo));
  return date.toISOString();
};

const clanNames = [
  "Dragon Warriors", "Phoenix Rising", "Shadow Legends", "Crystal Knights",
  "Thunder Strikers", "Ocean Masters", "Sky Guardians", "Fire Dragons",
  "Ice Wizards", "Storm Chasers", "Night Hawks", "Golden Eagles",
  "Silver Wolves", "Iron Titans", "Dark Knights", "Light Bringers",
  "Star Seekers", "Moon Walkers", "Sun Warriors", "Wind Runners",
  "Earth Shakers", "Flame Masters", "Water Spirits", "Nature Keepers",
  "Battle Legends", "Victory Squad", "Elite Force", "Power Rangers",
  "Ninja Warriors", "Samurai Clan", "Viking Raiders", "Spartan Army",
  "Roman Legion", "Greek Heroes", "Celtic Warriors", "Norse Gods",
  "Aztec Empire", "Mayan Kings", "Inca Warriors", "Egyptian Pharaohs",
  "Japanese Samurai", "Chinese Dragons", "Korean Tigers", "Thai Elephants",
  "Vietnamese Phoenix", "Indonesian Eagles", "Malaysian Panthers", "Singapore Lions",
  "Filipino Hawks", "Indian Tigers", "Pakistani Eagles", "Bangladeshi Warriors"
];

const leaderNames = [
  "John Smith", "Emma Wilson", "Michael Chen", "Sarah Johnson", "David Lee",
  "Emily Brown", "James Davis", "Lisa Garcia", "Robert Martinez", "Maria Rodriguez",
  "William Anderson", "Jennifer Taylor", "Richard Thomas", "Linda Moore", "Joseph Jackson",
  "Patricia White", "Charles Harris", "Barbara Martin", "Christopher Thompson", "Nancy Garcia",
  "Daniel Martinez", "Betty Robinson", "Matthew Clark", "Sandra Rodriguez", "Anthony Lewis",
  "Ashley Lee", "Mark Walker", "Kimberly Hall", "Donald Allen", "Carol Young"
];

const languages = ["English", "Spanish", "French", "German", "Chinese", "Japanese", "Korean", "Vietnamese", "Thai", "Indonesian"];
const regions = ["North America", "South America", "Europe", "Asia", "Oceania", "Africa"];
const tags = ["PvP", "PvE", "Casual", "Competitive", "Learning", "Social", "Trading", "Ranking", "Events", "Tournaments"];

export const mockClans: Clan[] = Array.from({ length: 50 }, (_, i) => {
  const id = randomId();
  const clanCode = `CLAN-${String(i + 1).padStart(4, "0")}`;
  const name = randomPick(clanNames);
  const leaderId = randomId();
  const leaderName = randomPick(leaderNames);
  const membersCount = randomInt(5, 50);
  const maxMembers = randomInt(30, 100);
  const language = randomPick(languages);
  const region = randomPick(regions);
  const levelRequirement = randomInt(1, 30);
  const privacy = randomPick<"Public" | "Private" | "Invite-only">(["Public", "Private", "Invite-only"]);
  const joinApproval = randomPick<"Auto" | "Manual">(["Auto", "Manual"]);
  const weeklyMessages = randomInt(0, 500);
  const createdAt = randomDate(120);
  const lastActiveAt = randomDate(7);

  // Status distribution: 70% Active, 20% Inactive, 10% Suspended
  let status: "Active" | "Inactive" | "Suspended";
  const rand = Math.random();
  if (rand < 0.7) status = "Active";
  else if (rand < 0.9) status = "Inactive";
  else status = "Suspended";

  // 20% missing optional fields
  const hasOptional = Math.random() > 0.2;

  return {
    id,
    clanCode,
    name,
    description: hasOptional ? `${name} is a ${privacy.toLowerCase()} clan focused on ${randomPick(tags).toLowerCase()} gameplay.` : undefined,
    leaderId,
    leaderName,
    membersCount,
    maxMembers,
    language,
    region,
    levelRequirement,
    privacy,
    joinApproval,
    status,
    bannerUrl: hasOptional ? `https://picsum.photos/seed/${id}/800/200` : undefined,
    avatarUrl: hasOptional ? `https://picsum.photos/seed/${id}/200/200` : undefined,
    tags: Array.from({ length: randomInt(1, 3) }, () => randomPick(tags)),
    weeklyMessages,
    weeklyBattles: hasOptional ? randomInt(0, 100) : undefined,
    reportsCount: hasOptional ? randomInt(0, 5) : undefined,
    createdAt,
    lastActiveAt,
  };
});
