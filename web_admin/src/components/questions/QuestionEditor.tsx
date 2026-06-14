'use client';

import { useEffect, useMemo, useState } from 'react';
import { Plus, Save, Trash2 } from 'lucide-react';
import { ActionButton } from '@/components/admin/ActionButton';
import type { BattleQuestion } from '@/types/battle-admin.types';
import type { QuestionPayload } from '@/lib/api/admin-battle';

const skills = ['GRAMMAR', 'LISTENING', 'VOCABULARY'];
const difficulties = ['EASY', 'MEDIUM', 'HARD'];
const types = ['MULTIPLE_CHOICE'];
const mediaTypes = ['AUDIO', 'IMAGE', 'VIDEO'];

const emptyPayload: QuestionPayload = {
  source: 'ADMIN_CREATED',
  skill: 'GRAMMAR',
  difficulty: 'EASY',
  type: 'MULTIPLE_CHOICE',
  promptText: '',
  explanation: '',
  correctOptionKey: 'A',
  maxTimeSec: 10,
  baseScore: 100,
  speedBonus: 50,
  options: [
    { key: 'A', text: '', orderIndex: 0 },
    { key: 'B', text: '', orderIndex: 1 },
    { key: 'C', text: '', orderIndex: 2 },
    { key: 'D', text: '', orderIndex: 3 },
  ],
  media: [],
  acceptedAnswers: [],
};

export function QuestionEditor({
  question,
  onCancel,
  onSubmit,
}: {
  question?: BattleQuestion | null;
  onCancel: () => void;
  onSubmit: (payload: QuestionPayload) => Promise<void>;
}) {
  const [saving, setSaving] = useState(false);
  const [payload, setPayload] = useState<QuestionPayload>(emptyPayload);

  useEffect(() => {
    if (!question) {
      setPayload(emptyPayload);
      return;
    }

    setPayload({
      source: question.source ?? 'ADMIN_CREATED',
      skill: question.skill ?? 'GRAMMAR',
      difficulty: question.difficulty ?? 'EASY',
      type: question.type ?? 'MULTIPLE_CHOICE',
      promptText: question.promptText ?? '',
      explanation: question.explanation ?? '',
      correctOptionKey: question.correctOptionKey ?? 'A',
      maxTimeSec: question.maxTimeSec ?? 10,
      baseScore: question.baseScore ?? 100,
      speedBonus: question.speedBonus ?? 50,
      media: question.media?.map((m, index) => ({
        type: m.type,
        url: m.url,
        durationSec: m.durationSec ?? undefined,
        mimeType: m.mimeType ?? undefined,
        orderIndex: m.orderIndex ?? index,
      })) ?? [],
      options: question.options?.map((o, index) => ({
        key: o.key,
        text: o.text ?? '',
        mediaUrl: o.mediaUrl ?? undefined,
        orderIndex: o.orderIndex ?? index,
      })) ?? emptyPayload.options,
      acceptedAnswers: question.acceptedAnswers ?? [],
    });
  }, [question]);

  const title = useMemo(() => (question ? 'Cập nhật câu hỏi' : 'Tạo câu hỏi battle'), [question]);

  function setField<K extends keyof QuestionPayload>(key: K, value: QuestionPayload[K]) {
    setPayload((prev) => ({ ...prev, [key]: value }));
  }

  async function submit() {
    setSaving(true);
    try {
      const cleaned: QuestionPayload = {
        ...payload,
        promptText: payload.promptText?.trim(),
        explanation: payload.explanation?.trim(),
        options: payload.options?.filter((option) => option.key.trim()).map((option, index) => ({
          ...option,
          key: option.key.trim().toUpperCase(),
          text: option.text?.trim(),
          mediaUrl: option.mediaUrl?.trim() || undefined,
          orderIndex: index,
        })),
        media: payload.media?.filter((media) => media.url.trim()).map((media, index) => ({
          ...media,
          url: media.url.trim(),
          mimeType: media.mimeType?.trim() || undefined,
          orderIndex: index,
        })),
        acceptedAnswers: payload.acceptedAnswers?.filter(Boolean),
      };
      await onSubmit(cleaned);
    } finally {
      setSaving(false);
    }
  }

  return (
    <div className="space-y-5">
      <div className="flex items-center justify-between gap-4">
        <div>
          <p className="text-xs font-black uppercase tracking-[0.2em] text-[var(--bb-muted)]">Question Editor</p>
          <h2 className="text-xl font-black">{title}</h2>
        </div>
        <div className="flex gap-2">
          <ActionButton type="button" variant="secondary" onClick={onCancel}>Đóng</ActionButton>
          <ActionButton type="button" onClick={submit} disabled={saving}>
            <Save className="h-4 w-4" /> {saving ? 'Đang lưu...' : 'Lưu'}
          </ActionButton>
        </div>
      </div>

      <div className="grid gap-4 md:grid-cols-3">
        <Field label="Skill"><select className="bb-input" value={payload.skill} onChange={(e) => setField('skill', e.target.value)}>{skills.map((v) => <option key={v}>{v}</option>)}</select></Field>
        <Field label="Difficulty"><select className="bb-input" value={payload.difficulty} onChange={(e) => setField('difficulty', e.target.value)}>{difficulties.map((v) => <option key={v}>{v}</option>)}</select></Field>
        <Field label="Type"><select className="bb-input" value={payload.type} onChange={(e) => setField('type', e.target.value)}>{types.map((v) => <option key={v}>{v}</option>)}</select></Field>
      </div>

      <Field label="Prompt text">
        <textarea className="bb-input min-h-[120px] resize-y" value={payload.promptText ?? ''} onChange={(e) => setField('promptText', e.target.value)} placeholder="Nhập nội dung câu hỏi..." />
      </Field>

      <Field label="Explanation">
        <textarea className="bb-input min-h-[90px] resize-y" value={payload.explanation ?? ''} onChange={(e) => setField('explanation', e.target.value)} placeholder="Giải thích đáp án sau khi battle kết thúc..." />
      </Field>

      <div className="grid gap-4 md:grid-cols-3">
        <Field label="Correct option"><input className="bb-input" value={payload.correctOptionKey ?? ''} onChange={(e) => setField('correctOptionKey', e.target.value.toUpperCase())} /></Field>
        <Field label="Max time (sec)"><input className="bb-input" type="number" min={5} max={35} value={payload.maxTimeSec} onChange={(e) => setField('maxTimeSec', Number(e.target.value))} /></Field>
        <Field label="Base / speed score"><div className="grid grid-cols-2 gap-2"><input className="bb-input" type="number" value={payload.baseScore} onChange={(e) => setField('baseScore', Number(e.target.value))} /><input className="bb-input" type="number" value={payload.speedBonus} onChange={(e) => setField('speedBonus', Number(e.target.value))} /></div></Field>
      </div>

      <div className="rounded-3xl border border-[var(--bb-border)] bg-[var(--bb-surface-soft)] p-4">
        <div className="flex items-center justify-between">
          <h3 className="font-black">Options</h3>
          <ActionButton type="button" variant="secondary" onClick={() => setField('options', [...(payload.options ?? []), { key: String.fromCharCode(65 + (payload.options?.length ?? 0)), text: '', orderIndex: payload.options?.length ?? 0 }])}><Plus className="h-4 w-4" />Add</ActionButton>
        </div>
        <div className="mt-4 space-y-3">
          {(payload.options ?? []).map((option, index) => (
            <div key={index} className="grid gap-2 rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-strong)] p-3 md:grid-cols-[80px_1fr_1fr_auto]">
              <input className="bb-input" value={option.key} onChange={(e) => setField('options', (payload.options ?? []).map((item, i) => i === index ? { ...item, key: e.target.value.toUpperCase() } : item))} />
              <input className="bb-input" value={option.text ?? ''} onChange={(e) => setField('options', (payload.options ?? []).map((item, i) => i === index ? { ...item, text: e.target.value } : item))} placeholder="Option text" />
              <input className="bb-input" value={option.mediaUrl ?? ''} onChange={(e) => setField('options', (payload.options ?? []).map((item, i) => i === index ? { ...item, mediaUrl: e.target.value } : item))} placeholder="Option media URL" />
              <ActionButton type="button" variant="danger" onClick={() => setField('options', (payload.options ?? []).filter((_, i) => i !== index))}><Trash2 className="h-4 w-4" /></ActionButton>
            </div>
          ))}
        </div>
      </div>

      <div className="rounded-3xl border border-[var(--bb-border)] bg-[var(--bb-surface-soft)] p-4">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="font-black">Media</h3>
            <p className="text-xs text-[var(--bb-muted)]">Backend hiện nhận media dạng URL, không phải binary upload.</p>
          </div>
          <ActionButton type="button" variant="secondary" onClick={() => setField('media', [...(payload.media ?? []), { type: 'AUDIO', url: '', orderIndex: payload.media?.length ?? 0 }])}><Plus className="h-4 w-4" />Add</ActionButton>
        </div>
        <div className="mt-4 space-y-3">
          {(payload.media ?? []).map((media, index) => (
            <div key={index} className="grid gap-2 rounded-2xl border border-[var(--bb-border)] bg-[var(--bb-surface-strong)] p-3 md:grid-cols-[140px_1fr_130px_1fr_auto]">
              <select className="bb-input" value={media.type} onChange={(e) => setField('media', (payload.media ?? []).map((item, i) => i === index ? { ...item, type: e.target.value } : item))}>{mediaTypes.map((v) => <option key={v}>{v}</option>)}</select>
              <input className="bb-input" value={media.url} onChange={(e) => setField('media', (payload.media ?? []).map((item, i) => i === index ? { ...item, url: e.target.value } : item))} placeholder="https://..." />
              <input className="bb-input" type="number" value={media.durationSec ?? ''} onChange={(e) => setField('media', (payload.media ?? []).map((item, i) => i === index ? { ...item, durationSec: e.target.value ? Number(e.target.value) : undefined } : item))} placeholder="sec" />
              <input className="bb-input" value={media.mimeType ?? ''} onChange={(e) => setField('media', (payload.media ?? []).map((item, i) => i === index ? { ...item, mimeType: e.target.value } : item))} placeholder="audio/mpeg" />
              <ActionButton type="button" variant="danger" onClick={() => setField('media', (payload.media ?? []).filter((_, i) => i !== index))}><Trash2 className="h-4 w-4" /></ActionButton>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

function Field({ label, children }: { label: string; children: React.ReactNode }) {
  return <label><span className="bb-label">{label}</span>{children}</label>;
}
