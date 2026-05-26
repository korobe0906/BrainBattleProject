import {
  Lesson,
  Question,
  ImportRecord,
  ExportRecord,
  MetadataTag,
  LESSON_LEVELS,
  LANGUAGES,
  SKILL_FOCUSES,
  QUESTION_TYPES,
  QUESTION_DIFFICULTIES,
  TAG_CATEGORIES,
} from "@/types/learningContent.types";

// =============== HELPERS ===============
function randomId(): string {
  return Math.random().toString(36).substring(2, 11);
}

function randomDateInLast120Days(): string {
  const now = new Date();
  const days = Math.floor(Math.random() * 120);
  const date = new Date(now.getTime() - days * 24 * 60 * 60 * 1000);
  return date.toISOString();
}

function randomPick<T>(arr: T[]): T {
  return arr[Math.floor(Math.random() * arr.length)];
}

function randomElement<T>(arr: T[], count: number): T[] {
  const result: T[] = [];
  for (let i = 0; i < count; i++) {
    result.push(randomPick(arr));
  }
  return [...new Set(result)];
}

const firstNames = [
  "Nguyen", "Tran", "Le", "Pham", "Hoang", "Dang", "Bui", "Do", "Vu", "Ngo",
  "John", "Sarah", "Michael", "Emma", "David", "Sophia", "James", "Olivia",
];

const lastNames = [
  "Anh", "Binh", "Chi", "Duc", "Eng", "Phuong", "Quoc", "Tam", "Tan", "Vy",
  "Smith", "Johnson", "Brown", "Taylor", "Williams", "Jones",
];

function randomName(): string {
  return `${randomPick(firstNames)} ${randomPick(lastNames)}`;
}

const titles = [
  "Introduction to English",
  "Advanced Grammar Mastery",
  "Spoken English Basics",
  "Business Communication",
  "Pronunciation Workshop",
  "Writing Skills Development",
  "TOEIC Preparation",
  "IELTS Band 7+",
  "Conversation Starter",
  "Academic English",
];

const descriptions = [
  "Learn fundamental English concepts",
  "Master advanced grammar rules and exceptions",
  "Improve your speaking fluency",
  "Professional communication strategies",
  "Develop clear pronunciation",
  "Write effectively in English",
  "Prepare for TOEIC exam",
  "Achieve high IELTS band score",
  "Build conversation confidence",
  "Academic writing techniques",
];

const topics = [
  "Grammar",
  "Vocabulary",
  "Pronunciation",
  "Listening",
  "Speaking",
  "Reading",
  "Writing",
  "Fluency",
  "Business",
  "Culture",
];

const tagNames = [
  "Beginner", "Intermediate", "Advanced", "Business", "Casual",
  "Present Tense", "Past Tense", "Future Tense", "Phrasal Verbs", "Idioms",
  "Food", "Travel", "Sports", "Technology", "Health",
  "Listening", "Speaking", "Writing", "Reading", "Pronunciation",
];

// =============== MOCK LESSONS ===============
export const mockLessons: Lesson[] = Array.from({ length: 50 }, (_, i) => {
  const createdAt = randomDateInLast120Days();
  return {
    id: randomId(),
    lessonCode: `AIM-${String(1001 + i).padStart(5, "0")}`,
    title: randomPick(titles),
    description: Math.random() > 0.2 ? randomPick(descriptions) : undefined,
    language: randomPick(LANGUAGES),
    level: randomPick(LESSON_LEVELS),
    skillFocus: randomPick(SKILL_FOCUSES),
    durationMinutes: Math.floor(Math.random() * 90) + 15,
    totalUnits: Math.floor(Math.random() * 20) + 2,
    status: randomPick(["Draft", "Published", "Archived"] as const),
    createdBy: randomName(),
    createdAt,
    updatedAt: new Date(
      new Date(createdAt).getTime() + Math.random() * 30 * 24 * 60 * 60 * 1000
    ).toISOString(),
    tags: randomElement(tagNames, Math.floor(Math.random() * 4) + 1),
    thumbnailUrl: Math.random() > 0.3 ? `https://via.placeholder.com/400x300?text=Lesson-${i}` : undefined,
    estimatedDifficulty: (Math.floor(Math.random() * 5) + 1) as 1 | 2 | 3 | 4 | 5,
    metrics: {
      enrollments: Math.floor(Math.random() * 5000),
      completions: Math.floor(Math.random() * 3000),
      avgScore: Math.floor(Math.random() * 40) + 60,
    },
    visibility: randomPick(["Public", "Private", "Restricted"] as const),
  };
});

// =============== MOCK QUESTIONS ===============
export const mockQuestions: Question[] = Array.from({ length: 80 }, (_, i) => {
  const createdAt = randomDateInLast120Days();
  const type = randomPick(QUESTION_TYPES);
  
  let answers: Array<{id: string; text: string; isCorrect: boolean}> = [];
  if (type === "MCQ" || type === "TrueFalse") {
    const correctIdx = Math.floor(Math.random() * (type === "TrueFalse" ? 2 : 4));
    answers = Array.from({ length: type === "TrueFalse" ? 2 : 4 }, (_, j) => ({
      id: randomId(),
      text: `Option ${String.fromCharCode(65 + j)}`,
      isCorrect: j === correctIdx,
    }));
  }

  return {
    id: randomId(),
    questionCode: `Q-${String(100001 + i).padStart(6, "0")}`,
    questionText: `What is the correct answer for question ${i + 1}?`,
    type,
    language: randomPick(LANGUAGES),
    level: randomPick(LESSON_LEVELS),
    topic: randomPick(topics),
    difficulty: randomPick(QUESTION_DIFFICULTIES),
    answers,
    correctAnswer: type !== "MCQ" && type !== "TrueFalse" ? "Correct answer text" : undefined,
    explanation: Math.random() > 0.2 ? "This is the correct explanation..." : undefined,
    hint: Math.random() > 0.3 ? "This is a helpful hint..." : undefined,
    timeLimitSeconds: Math.floor(Math.random() * 60) + 30,
    points: Math.floor(Math.random() * 50) + 10,
    status: randomPick(["Active", "Inactive", "Archived"] as const),
    createdBy: randomName(),
    createdAt,
    updatedAt: new Date(
      new Date(createdAt).getTime() + Math.random() * 30 * 24 * 60 * 60 * 1000
    ).toISOString(),
    tags: randomElement(tagNames, Math.floor(Math.random() * 3) + 1),
    usageStats: {
      usedInLessons: Math.floor(Math.random() * 20),
      attempts: Math.floor(Math.random() * 10000),
      correctRate: Math.random(),
    },
  };
});

// =============== MOCK IMPORTS ===============
export const mockImports: ImportRecord[] = Array.from({ length: 20 }, (_, i) => {
  const uploadedAt = randomDateInLast120Days();
  const status = randomPick(["Pending", "Processing", "Success", "Failed"] as const);
  
  return {
    id: randomId(),
    fileName: `import-${status.toLowerCase()}-${i}.${randomPick(["csv", "xlsx", "json"])}`,
    fileType: randomPick(["csv", "xlsx", "json"] as const),
    module: randomPick(["Lessons", "Questions", "Tags"] as const),
    status,
    uploadedBy: randomName(),
    uploadedAt,
    processedAt:
      status !== "Pending"
        ? new Date(new Date(uploadedAt).getTime() + Math.random() * 3600 * 1000).toISOString()
        : undefined,
    totalRecords: Math.floor(Math.random() * 1000) + 50,
    successCount: Math.floor(Math.random() * 900) + 50,
    failedCount: Math.floor(Math.random() * 100),
    errorLog: status === "Failed" ? "Some records failed validation" : undefined,
  };
});

// =============== MOCK EXPORTS ===============
export const mockExports: ExportRecord[] = Array.from({ length: 20 }, (_, i) => {
  const requestedAt = randomDateInLast120Days();
  const status = randomPick(["Queued", "Generating", "Ready", "Failed"] as const);
  
  return {
    id: randomId(),
    exportName: `Export-${new Date(requestedAt).toLocaleDateString()}-${i}`,
    module: randomPick(["Lessons", "Questions", "Tags"] as const),
    format: randomPick(["csv", "xlsx", "json"] as const),
    status,
    requestedBy: randomName(),
    requestedAt,
    completedAt:
      status === "Ready" || status === "Failed"
        ? new Date(new Date(requestedAt).getTime() + Math.random() * 5 * 60 * 1000).toISOString()
        : undefined,
    downloadUrl: status === "Ready" ? `https://example.com/exports/${randomId()}.zip` : undefined,
    recordCount: Math.floor(Math.random() * 5000) + 100,
  };
});

// =============== MOCK TAGS ===============
export const mockTags: MetadataTag[] = Array.from({ length: 30 }, (_, i) => {
  const createdAt = randomDateInLast120Days();
  const category = randomPick(TAG_CATEGORIES);
  
  return {
    id: randomId(),
    tagCode: `TAG-${String(5001 + i).padStart(4, "0")}`,
    name: tagNames[i % tagNames.length],
    category,
    description: Math.random() > 0.3 ? `Description for ${tagNames[i % tagNames.length]} tag` : undefined,
    color: `#${Math.floor(Math.random() * 16777215).toString(16).padStart(6, "0")}`,
    status: randomPick(["Active", "Inactive"] as const),
    createdBy: randomName(),
    createdAt,
    updatedAt: new Date(
      new Date(createdAt).getTime() + Math.random() * 30 * 24 * 60 * 60 * 1000
    ).toISOString(),
    usageCount: Math.floor(Math.random() * 500),
    synonyms: Math.random() > 0.5 ? [randomPick(tagNames), randomPick(tagNames)] : undefined,
  };
});
