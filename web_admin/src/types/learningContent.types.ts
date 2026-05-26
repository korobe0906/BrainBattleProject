// =============== LESSONS ===============
export type LessonLevel = "A1" | "A2" | "B1" | "B2" | "C1" | "C2";
export type LessonSkillFocus = "Listening" | "Speaking" | "Reading" | "Writing" | "Mixed";
export type LessonStatus = "Draft" | "Published" | "Archived";
export type ContentVisibility = "Public" | "Private" | "Restricted";

export interface Lesson {
  id: string;
  lessonCode: string; // AIM-xxxx
  title: string;
  description?: string;
  language: string; // en, vi, ja, kr, fr...
  level: LessonLevel;
  skillFocus: LessonSkillFocus;
  durationMinutes: number;
  totalUnits: number;
  status: LessonStatus;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  tags: string[];
  thumbnailUrl?: string;
  estimatedDifficulty: 1 | 2 | 3 | 4 | 5;
  metrics: {
    enrollments: number;
    completions: number;
    avgScore: number; // 0-100
  };
  visibility: ContentVisibility;
}

// =============== QUESTIONS ===============
export type QuestionType = "MCQ" | "TrueFalse" | "FillBlank" | "Matching" | "ShortAnswer";
export type QuestionDifficulty = "Easy" | "Medium" | "Hard";
export type QuestionStatus = "Active" | "Inactive" | "Archived";

export interface Answer {
  id: string;
  text: string;
  isCorrect: boolean;
}

export interface Question {
  id: string;
  questionCode: string; // Q-xxxxxx
  questionText: string;
  type: QuestionType;
  language: string;
  level: LessonLevel;
  topic: string;
  difficulty: QuestionDifficulty;
  answers: Answer[];
  correctAnswer?: string; // for non-MCQ
  explanation?: string;
  hint?: string;
  timeLimitSeconds: number;
  points: number;
  status: QuestionStatus;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  tags: string[];
  usageStats: {
    usedInLessons: number;
    attempts: number;
    correctRate: number; // 0-1
  };
}

// =============== IMPORT / EXPORT ===============
export type ImportStatus = "Pending" | "Processing" | "Success" | "Failed";
export type ExportStatus = "Queued" | "Generating" | "Ready" | "Failed";
export type FileType = "csv" | "xlsx" | "json";
export type ImportExportModule = "Lessons" | "Questions" | "Tags";

export interface ImportRecord {
  id: string;
  fileName: string;
  fileType: FileType;
  module: ImportExportModule;
  status: ImportStatus;
  uploadedBy: string;
  uploadedAt: string;
  processedAt?: string;
  totalRecords: number;
  successCount: number;
  failedCount: number;
  errorLog?: string;
}

export interface ExportRecord {
  id: string;
  exportName: string;
  module: ImportExportModule;
  format: FileType;
  status: ExportStatus;
  requestedBy: string;
  requestedAt: string;
  completedAt?: string;
  downloadUrl?: string;
  recordCount: number;
}

// =============== METADATA TAGS ===============
export type TagCategory = "Topic" | "Grammar" | "Vocab" | "Skill" | "Other";
export type TagStatus = "Active" | "Inactive";

export interface MetadataTag {
  id: string;
  tagCode: string; // TAG-xxx
  name: string;
  category: TagCategory;
  description?: string;
  color: string; // hex
  status: TagStatus;
  createdBy: string;
  createdAt: string;
  updatedAt: string;
  usageCount: number;
  synonyms?: string[];
}

// =============== CONSTANTS ===============
export const LESSON_LEVELS: LessonLevel[] = ["A1", "A2", "B1", "B2", "C1", "C2"];
export const LANGUAGES = ["en", "vi", "ja", "kr", "fr"];
export const SKILL_FOCUSES: LessonSkillFocus[] = ["Listening", "Speaking", "Reading", "Writing", "Mixed"];
export const QUESTION_TYPES: QuestionType[] = ["MCQ", "TrueFalse", "FillBlank", "Matching", "ShortAnswer"];
export const QUESTION_DIFFICULTIES: QuestionDifficulty[] = ["Easy", "Medium", "Hard"];
export const TAG_CATEGORIES: TagCategory[] = ["Topic", "Grammar", "Vocab", "Skill", "Other"];
