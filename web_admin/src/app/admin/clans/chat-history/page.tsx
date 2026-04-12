"use client";

import { useEffect, useMemo, useState } from "react";
import { ChatHeader } from "@/components/clans/ChatHeader";
import { ChatToolbar } from "@/components/clans/ChatToolbar";
import { ChatTable } from "@/components/clans/ChatTable";
import { ChatMessage, MessageStatus, MessageType } from "@/types/clanGuild.types";
import { mockChatMessages } from "@/mock/clanGuild/chat.mock";

const ITEMS_PER_PAGE = 20;

export default function ChatHistoryPage() {
  const [messages, setMessages] = useState<ChatMessage[]>([]);
  const [q, setQ] = useState("");
  const [status, setStatus] = useState<MessageStatus | "All">("All");
  const [messageType, setMessageType] = useState<MessageType | "All">("All");
  const [clanFilter, setClanFilter] = useState("");
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    setMessages(mockChatMessages);
  }, []);

  const filtered = useMemo(() => {
    return messages.filter((msg) => {
      const matchesQ =
        q === "" ||
        msg.messagePreview.toLowerCase().includes(q.toLowerCase()) ||
        msg.senderName.toLowerCase().includes(q.toLowerCase());

      const matchesStatus = status === "All" || msg.status === status;
      const matchesType = messageType === "All" || msg.messageType === messageType;
      const matchesClan =
        clanFilter === "" || msg.clanName.toLowerCase().includes(clanFilter.toLowerCase());

      return matchesQ && matchesStatus && matchesType && matchesClan;
    });
  }, [messages, q, status, messageType, clanFilter]);

  const totalPages = Math.ceil(filtered.length / ITEMS_PER_PAGE);
  const paginatedMessages = filtered.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  const handleToggleSelect = (id: string) => {
    const newSelected = new Set(selectedIds);
    if (newSelected.has(id)) {
      newSelected.delete(id);
    } else {
      newSelected.add(id);
    }
    setSelectedIds(newSelected);
  };

  const handleToggleAll = (checked: boolean) => {
    if (checked) {
      setSelectedIds(new Set(paginatedMessages.map((m) => m.id)));
    } else {
      setSelectedIds(new Set());
    }
  };

  return (
    <div className="space-y-6">
      <ChatHeader />

      <ChatToolbar
        q={q}
        onQChange={setQ}
        status={status}
        onStatusChange={setStatus}
        messageType={messageType}
        onMessageTypeChange={setMessageType}
        clanFilter={clanFilter}
        onClanFilterChange={setClanFilter}
      />

      <ChatTable
        messages={paginatedMessages}
        selectedIds={selectedIds}
        onToggleSelect={handleToggleSelect}
        onToggleAll={handleToggleAll}
      />

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filtered.length)} of {filtered.length} messages
        </div>
        <div className="flex gap-2">
          <button
            type={"button" as const}
            onClick={() => setCurrentPage((p) => Math.max(1, p - 1))}
            disabled={currentPage === 1}
            className="px-3 py-1 rounded-lg border border-gray-200 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50"
          >
            Previous
          </button>
          <div className="flex items-center gap-1">
            {Array.from({ length: Math.min(5, totalPages) }).map((_, i) => {
              const pageNum = i + 1;
              return (
                <button
                  key={pageNum}
                  type={"button" as const}
                  onClick={() => setCurrentPage(pageNum)}
                  className={`px-2 py-1 rounded text-sm ${
                    currentPage === pageNum
                      ? "bg-pink-600 text-white"
                      : "border border-gray-200 text-gray-700 hover:bg-gray-50"
                  }`}
                >
                  {pageNum}
                </button>
              );
            })}
          </div>
          <button
            type={"button" as const}
            onClick={() => setCurrentPage((p) => Math.min(totalPages, p + 1))}
            disabled={currentPage === totalPages}
            className="px-3 py-1 rounded-lg border border-gray-200 text-sm text-gray-700 hover:bg-gray-50 disabled:opacity-50"
          >
            Next
          </button>
        </div>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Total Messages</div>
          <div className="text-2xl font-bold text-gray-900 mt-2">{messages.length}</div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Normal</div>
          <div className="text-2xl font-bold text-emerald-600 mt-2">
            {messages.filter((m) => m.status === "Normal").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Flagged</div>
          <div className="text-2xl font-bold text-amber-600 mt-2">
            {messages.filter((m) => m.status === "Flagged").length}
          </div>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4">
          <div className="text-sm text-gray-600">Hidden/Deleted</div>
          <div className="text-2xl font-bold text-rose-600 mt-2">
            {messages.filter((m) => m.status === "Hidden" || m.status === "Deleted").length}
          </div>
        </div>
      </div>
    </div>
  );
}
