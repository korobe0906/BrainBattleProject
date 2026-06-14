'use client';

import { useEffect, useMemo, useState } from 'react';
import { CheckCircle2, FileQuestion, Plus, RefreshCw, ShieldCheck, XCircle } from 'lucide-react';
import { PageHero } from '@/components/admin/PageHero';
import { SurfaceCard } from '@/components/admin/SurfaceCard';
import { MetricCard } from '@/components/admin/MetricCard';
import { EmptyState } from '@/components/admin/EmptyState';
import { StatusBadge } from '@/components/admin/StatusBadge';
import { SearchBox, SelectFilter } from '@/components/admin/Toolbar';
import { ActionButton } from '@/components/admin/ActionButton';
import { QuestionEditor } from '@/components/questions/QuestionEditor';
import { adminBattleApi, unwrapItems, type QuestionPayload } from '@/lib/api/admin-battle';
import type { BattleQuestion } from '@/types/battle-admin.types';

const statuses = ['All', 'DRAFT', 'PENDING_REVIEW', 'APPROVED', 'REJECTED', 'ARCHIVED'];
const skills = ['All', 'GRAMMAR', 'LISTENING', 'VOCABULARY'];
const difficulties = ['All', 'EASY', 'MEDIUM', 'HARD'];

export default function QuestionBankPage() {
  const [questions, setQuestions] = useState<BattleQuestion[]>([]);
  const [selected, setSelected] = useState<BattleQuestion | null>(null);
  const [editing, setEditing] = useState(false);
  const [q, setQ] = useState('');
  const [status, setStatus] = useState('All');
  const [skill, setSkill] = useState('All');
  const [difficulty, setDifficulty] = useState('All');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  async function reload() {
    setLoading(true);
    setError('');
    try {
      const data = await adminBattleApi.listQuestions({
        q: q || undefined,
        status: status === 'All' ? undefined : status,
        skill: skill === 'All' ? undefined : skill,
        difficulty: difficulty === 'All' ? undefined : difficulty,
        page: 1,
        limit: 100,
      });
      setQuestions(unwrapItems(data));
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Cannot load question bank');
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    reload();
  }, []);

  const stats = useMemo(() => ({
    total: questions.length,
    approved: questions.filter((item) => item.status === 'APPROVED').length,
    review: questions.filter((item) => item.status === 'PENDING_REVIEW').length,
    media: questions.filter((item) => (item.media?.length ?? 0) > 0).length,
  }), [questions]);

  async function saveQuestion(payload: QuestionPayload) {
    if (selected) await adminBattleApi.updateQuestion(selected.id, payload);
    else await adminBattleApi.createQuestion(payload);
    setEditing(false);
    setSelected(null);
    await reload();
  }

  async function action(question: BattleQuestion, type: 'validate' | 'submit' | 'approve' | 'reject' | 'archive' | 'version') {
    if (type === 'validate') await adminBattleApi.validateQuestion(question.id);
    if (type === 'submit') await adminBattleApi.submitQuestion(question.id);
    if (type === 'approve') await adminBattleApi.approveQuestion(question.id);
    if (type === 'reject') await adminBattleApi.rejectQuestion(question.id, 'Rejected from admin dashboard');
    if (type === 'archive') await adminBattleApi.archiveQuestion(question.id);
    if (type === 'version') await adminBattleApi.newQuestionVersion(question.id);
    await reload();
  }

  return (
    <div className="space-y-6 pb-10">
      <PageHero
        eyebrow="Battle Content Operations"
        title="Question Bank"
        description="Quản lý ngân hàng câu hỏi battle thật: skill, độ khó, đáp án, media URL, review, approve và dữ liệu dùng trực tiếp khi người chơi vào trận."
        icon={FileQuestion}
        actions={<ActionButton onClick={() => { setSelected(null); setEditing(true); }}><Plus className="h-4 w-4" /> New question</ActionButton>}
      />

      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        <MetricCard icon={FileQuestion} label="Questions" value={stats.total} />
        <MetricCard icon={ShieldCheck} label="Approved" value={stats.approved} />
        <MetricCard icon={RefreshCw} label="Pending review" value={stats.review} />
        <MetricCard icon={CheckCircle2} label="With media" value={stats.media} />
      </div>

      {editing ? (
        <SurfaceCard className="p-5 md:p-6">
          <QuestionEditor question={selected} onCancel={() => { setEditing(false); setSelected(null); }} onSubmit={saveQuestion} />
        </SurfaceCard>
      ) : null}

      <SurfaceCard className="p-5">
        <div className="flex flex-col gap-3 xl:flex-row xl:items-center">
          <SearchBox value={q} onChange={setQ} placeholder="Tìm prompt, source, external id..." />
          <SelectFilter value={status} onChange={setStatus} options={statuses} />
          <SelectFilter value={skill} onChange={setSkill} options={skills} />
          <SelectFilter value={difficulty} onChange={setDifficulty} options={difficulties} />
          <ActionButton variant="secondary" onClick={reload}><RefreshCw className="h-4 w-4" />Load</ActionButton>
        </div>
      </SurfaceCard>

      <SurfaceCard className="overflow-hidden">
        {error ? <div className="p-5 text-sm font-bold text-[var(--bb-red)]">{error}</div> : null}
        {!loading && !questions.length ? <div className="p-5"><EmptyState title="Chưa có câu hỏi" description="Question bank hiện chưa có dữ liệu từ backend hoặc bộ lọc hiện tại không có kết quả." /></div> : null}
        {questions.length ? (
          <div className="bb-scrollbar overflow-x-auto">
            <table className="bb-table">
              <thead><tr><th>Question</th><th>Skill</th><th>Status</th><th>Score</th><th>Media</th><th>Actions</th></tr></thead>
              <tbody>
                {questions.map((question) => (
                  <tr key={question.id}>
                    <td>
                      <p className="max-w-xl font-black">{question.promptText || 'Untitled question'}</p>
                      <p className="mt-1 text-xs text-[var(--bb-muted)]">ID: {question.id} · v{question.version ?? 1}</p>
                      {question.options?.length ? <p className="mt-2 text-xs text-[var(--bb-muted)]">Options: {question.options.map((o) => `${o.key}. ${o.text ?? o.mediaUrl ?? '-'}`).join(' / ')}</p> : null}
                    </td>
                    <td><StatusBadge value={question.skill} /><p className="mt-2 text-xs text-[var(--bb-muted)]">{question.difficulty}</p></td>
                    <td><StatusBadge value={question.status} /></td>
                    <td><p className="font-black">{question.baseScore ?? 0}+{question.speedBonus ?? 0}</p><p className="text-xs text-[var(--bb-muted)]">{question.maxTimeSec}s</p></td>
                    <td><p className="font-black">{question.media?.length ?? 0}</p><p className="text-xs text-[var(--bb-muted)]">assets</p></td>
                    <td>
                      <div className="flex flex-wrap gap-2">
                        <ActionButton variant="secondary" onClick={() => { setSelected(question); setEditing(true); }}>Edit</ActionButton>
                        <ActionButton variant="secondary" onClick={() => action(question, 'validate')}>Validate</ActionButton>
                        <ActionButton variant="secondary" onClick={() => action(question, 'submit')}>Submit</ActionButton>
                        <ActionButton variant="secondary" onClick={() => action(question, 'approve')}>Approve</ActionButton>
                        <ActionButton variant="danger" onClick={() => action(question, 'reject')}><XCircle className="h-4 w-4" />Reject</ActionButton>
                        <ActionButton variant="secondary" onClick={() => action(question, 'archive')}>Archive</ActionButton>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : null}
      </SurfaceCard>
    </div>
  );
}
