export type Paginated<T> = {
  page?: number;
  limit?: number;
  total?: number;
  totalPages?: number;
  items?: T[];
};

export type BattleQuestionOption = {
  id?: string;
  key: string;
  text?: string | null;
  mediaUrl?: string | null;
  orderIndex?: number;
};

export type BattleQuestionMedia = {
  id?: string;
  type: 'AUDIO' | 'IMAGE' | 'VIDEO';
  url: string;
  durationSec?: number | null;
  mimeType?: string | null;
  orderIndex?: number;
};

export type BattleQuestion = {
  id: string;
  questionGroupId?: string;
  version?: number;
  status?: string;
  source?: string;
  skill?: string;
  difficulty?: string;
  type?: string;
  promptText?: string | null;
  explanation?: string | null;
  correctOptionKey?: string | null;
  acceptedAnswers?: string[];
  maxTimeSec?: number;
  baseScore?: number;
  speedBonus?: number;
  media?: BattleQuestionMedia[];
  options?: BattleQuestionOption[];
  createdAt?: string;
  updatedAt?: string;
};

export type AdminBattle = {
  battleId: string;
  roomId?: string;
  roomCode?: string;
  format?: string;
  skill?: string;
  status?: string;
  isRanked?: boolean;
  questionCount?: number;
  playerCount?: number;
  submissionCount?: number;
  startedAt?: string | null;
  finishedAt?: string | null;
  createdAt?: string;
  scoreboard?: Array<Record<string, unknown>>;
  teamSummary?: Record<string, unknown> | null;
};

export type AdminRoom = {
  id: string;
  code?: string;
  format?: string;
  skill?: string;
  status?: string;
  hostUserId?: string;
  members?: Array<Record<string, unknown>>;
  createdAt?: string;
  expiresAt?: string | null;
  analysis?: Record<string, unknown>;
};

export type ShopItem = {
  id?: string;
  code: string;
  name: string;
  description?: string;
  costBp: number;
  isActive?: boolean;
  sortOrder?: number;
};

export type InventoryItem = {
  id: string;
  userId: string;
  itemCode: string;
  status: string;
  acquiredAt?: string;
  activatedAt?: string | null;
  usedAt?: string | null;
  battleId?: string | null;
  item?: ShopItem;
};

export type OnchainRecord = {
  id?: string;
  battleId?: string;
  status?: string;
  txHash?: string | null;
  resultHash?: string | null;
  blockNumber?: string | number | null;
  chainId?: string | number | null;
  contractAddress?: string | null;
  errorMessage?: string | null;
  recordedAt?: string | null;
  createdAt?: string;
};
