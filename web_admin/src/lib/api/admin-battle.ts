import { apiClient } from './client';
import type { AdminBattle, AdminRoom, BattleQuestion, InventoryItem, OnchainRecord, Paginated, ShopItem } from '@/types/battle-admin.types';

export type QuestionPayload = {
  source?: string;
  skill: string;
  difficulty: string;
  type: string;
  promptText?: string;
  explanation?: string;
  media?: Array<{ type: string; url: string; durationSec?: number; mimeType?: string; orderIndex?: number }>;
  options?: Array<{ key: string; text?: string; mediaUrl?: string; orderIndex?: number }>;
  correctOptionKey?: string;
  acceptedAnswers?: string[];
  maxTimeSec: number;
  baseScore?: number;
  speedBonus?: number;
};

function normalizeQuestionResponse(payload: any) {
  return payload?.question ?? payload;
}

export const adminBattleApi = {
  listQuestions(params?: Record<string, string | number | undefined>) {
    return apiClient.get<Paginated<BattleQuestion> | BattleQuestion[]>('/admin/questions', params);
  },
  getQuestion(questionId: string) {
    return apiClient.get<any>(`/admin/questions/${questionId}`).then(normalizeQuestionResponse) as Promise<BattleQuestion>;
  },
  createQuestion(payload: QuestionPayload) {
    return apiClient.post<any>('/admin/questions', payload).then(normalizeQuestionResponse) as Promise<BattleQuestion>;
  },
  updateQuestion(questionId: string, payload: Partial<QuestionPayload>) {
    return apiClient.patch<any>(`/admin/questions/${questionId}`, payload).then(normalizeQuestionResponse) as Promise<BattleQuestion>;
  },
  validateQuestion(questionId: string) {
    return apiClient.post(`/admin/questions/${questionId}/validate`);
  },
  submitQuestion(questionId: string) {
    return apiClient.post(`/admin/questions/${questionId}/submit-review`);
  },
  approveQuestion(questionId: string) {
    return apiClient.post(`/admin/questions/${questionId}/approve`);
  },
  rejectQuestion(questionId: string, reason: string) {
    return apiClient.post(`/admin/questions/${questionId}/reject`, { reason });
  },
  archiveQuestion(questionId: string) {
    return apiClient.post(`/admin/questions/${questionId}/archive`);
  },
  newQuestionVersion(questionId: string) {
    return apiClient.post(`/admin/questions/${questionId}/new-version`);
  },
  listRooms(params?: Record<string, string | number | undefined>) {
    return apiClient.get<Paginated<AdminRoom>>('/admin/rooms', params);
  },
  getRoom(roomId: string) {
    return apiClient.get<AdminRoom>(`/admin/rooms/${roomId}`);
  },
  forceCancelRoom(roomId: string) {
    return apiClient.post<AdminRoom>(`/admin/rooms/${roomId}/force-cancel`);
  },
  listBattles(params?: Record<string, string | number | undefined>) {
    return apiClient.get<Paginated<AdminBattle>>('/admin/battles', params);
  },
  getBattle(battleId: string) {
    return apiClient.get<Record<string, unknown>>(`/admin/battles/${battleId}`);
  },
  getSettlement(battleId: string) {
    return apiClient.get<Record<string, unknown> | null>(`/admin/battles/${battleId}/settlement`);
  },
  getSettlementPayload(battleId: string) {
    return apiClient.get<Record<string, unknown>>(`/admin/battles/${battleId}/settlement-payload`);
  },
  recordOnchain(battleId: string) {
    return apiClient.post<OnchainRecord>(`/admin/battles/${battleId}/record-onchain`);
  },
  getOnchainRecord(battleId: string) {
    return apiClient.get<OnchainRecord | null>(`/admin/battles/${battleId}/onchain-record`);
  },
  getRewardWallet(userId: string) {
    return apiClient.get<Record<string, unknown> | null>(`/admin/rewards/${userId}/wallet`);
  },
  getRewardLedger(userId: string, page = 1, limit = 20) {
    return apiClient.get<Paginated<Record<string, unknown>>>(`/admin/rewards/${userId}/ledger`, { page, limit });
  },
  getRank(userId: string) {
    return apiClient.get<Record<string, unknown> | null>(`/admin/rank/${userId}`);
  },
  getRankLogs(userId: string) {
    return apiClient.get<Record<string, unknown>[]>(`/admin/rank/${userId}/logs`);
  },
  listShopItems() {
    return apiClient.get<ShopItem[]>('/admin/shop/items');
  },
  listInventory(userId?: string) {
    return apiClient.get<InventoryItem[]>('/admin/shop/inventory', { userId });
  },
};

export function unwrapItems<T>(data: Paginated<T> | T[] | undefined | null): T[] {
  if (!data) return [];
  return Array.isArray(data) ? data : data.items ?? [];
}
