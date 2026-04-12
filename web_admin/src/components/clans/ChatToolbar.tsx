"use client";

import { Search, ChevronDown } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { MessageStatus, MESSAGE_STATUSES, MessageType, MESSAGE_TYPES } from "@/types/clanGuild.types";

interface FilterDropdownProps {
  icon: React.ReactNode;
  label: string;
  options: string[];
  value: string;
  onChange: (val: string) => void;
}

function FilterDropdown({ icon, label, options, value, onChange }: FilterDropdownProps) {
  const [open, setOpen] = useState(false);
  const wrapRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleClick = (e: MouseEvent) => {
      if (wrapRef.current && !wrapRef.current.contains(e.target as Node)) {
        setOpen(false);
      }
    };
    const handleKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    document.addEventListener("mousedown", handleClick);
    document.addEventListener("keydown", handleKey);
    return () => {
      document.removeEventListener("mousedown", handleClick);
      document.removeEventListener("keydown", handleKey);
    };
  }, []);

  return (
    <div className="relative" ref={wrapRef}>
      <button
        type={"button" as const}
        onClick={() => setOpen(!open)}
        className="
          inline-flex items-center gap-2 px-4 py-2 
          bg-white border border-gray-200 rounded-xl 
          text-sm font-medium text-gray-700 
          hover:bg-gray-50 transition
        "
      >
        {icon}
        {label}: <span className="text-gray-900">{value}</span>
        <ChevronDown className="w-4 h-4 text-gray-400" />
      </button>

      {open && (
        <div className="absolute left-0 top-full mt-2 w-48 bg-white border border-gray-200 rounded-2xl shadow-xl z-50 py-2 animate-in fade-in zoom-in-95">
          {options.map((opt) => (
            <button
              key={opt}
              type={"button" as const}
              onClick={() => {
                onChange(opt);
                setOpen(false);
              }}
              className={`
                w-full text-left px-4 py-2 text-sm transition
                ${opt === value ? "bg-pink-50 text-pink-700 font-semibold" : "text-gray-700 hover:bg-gray-50"}
              `}
            >
              {opt}
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

interface ChatToolbarProps {
  q: string;
  onQChange: (q: string) => void;
  status: MessageStatus | "All";
  onStatusChange: (s: MessageStatus | "All") => void;
  messageType: MessageType | "All";
  onMessageTypeChange: (t: MessageType | "All") => void;
  clanFilter: string;
  onClanFilterChange: (c: string) => void;
}

export function ChatToolbar({
  q,
  onQChange,
  status,
  onStatusChange,
  messageType,
  onMessageTypeChange,
  clanFilter,
  onClanFilterChange,
}: ChatToolbarProps) {
  const STATUS_OPTIONS = ["All", ...MESSAGE_STATUSES];
  const TYPE_OPTIONS = ["All", ...MESSAGE_TYPES];

  return (
    <div className="flex flex-col lg:flex-row gap-3 lg:items-center lg:justify-between">
      <div className="relative flex-1 max-w-md">
        <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400 pointer-events-none" />
        <input
          type="text"
          value={q}
          onChange={(e: React.ChangeEvent<HTMLInputElement>) => onQChange(e.target.value)}
          placeholder="Search messages by content or sender..."
          className="
            w-full pl-10 pr-4 py-2.5 
            bg-white border border-gray-200 rounded-xl 
            text-sm text-gray-900 placeholder-gray-400
            focus:outline-none focus:ring-2 focus:ring-pink-500 focus:border-transparent
            transition
          "
        />
      </div>

      <div className="flex flex-wrap gap-2">
        <input
          type="text"
          value={clanFilter}
          onChange={(e: React.ChangeEvent<HTMLInputElement>) => onClanFilterChange(e.target.value)}
          placeholder="Filter by clan name..."
          className="
            px-4 py-2 
            bg-white border border-gray-200 rounded-xl 
            text-sm text-gray-700 placeholder-gray-400
            focus:outline-none focus:ring-2 focus:ring-pink-500 focus:border-transparent
            transition
          "
        />

        <FilterDropdown
          icon={<span className="text-gray-500">📊</span>}
          label="Status"
          options={STATUS_OPTIONS}
          value={status}
          onChange={(v: string) => onStatusChange(v as MessageStatus | "All")}
        />

        <FilterDropdown
          icon={<span className="text-gray-500">💬</span>}
          label="Type"
          options={TYPE_OPTIONS}
          value={messageType}
          onChange={(v: string) => onMessageTypeChange(v as MessageType | "All")}
        />
      </div>
    </div>
  );
}
