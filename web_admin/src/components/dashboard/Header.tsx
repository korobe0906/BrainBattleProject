"use client";

import Image from "next/image";
import { usePathname } from "next/navigation";
import { Download, UserPlus, ShieldAlert, Plus, Upload, FileUp, Tags, Users, MessageSquare, Ban, Hash } from "lucide-react";

const pageInfo: Record<string, { title: string; description: string }> = {
  "/admin": {
    title: "Dashboard",
    description: "Monitor brand visibility & performance across AI models",
  },
  "/admin/users/learners": {
    title: "Learners",
    description: "Manage learner accounts and activity",
  },
  "/admin/users": {
    title: "User Management",
    description: "Control and manage system users",
  },
  "/admin/users/creators": {
    title: "Creators & Access Rights",
    description: "Manage creators and permission levels",
  },
   "/admin/users/violations": {
    title: "Violation Reports",
    description: "Review reports, moderate content, and apply penalties",
  },
  "/admin/learning/units": {
    title: "AIM Lessons",
    description: "Manage lesson content, structure, and publishing",
  },
  "/admin/learning/questions": {
    title: "Question Bank",
    description: "Manage questions, difficulty, and usage across lessons",
  },
  "/admin/learning/import-export": {
    title: "Import / Export",
    description: "Bulk upload and export learning content",
  },
  "/admin/learning/tags": {
    title: "Metadata Tags",
    description: "Organize lessons and questions using standardized tags",
  },
  "/admin/clans/clan-list": {
    title: "Clan List",
    description: "Manage clans, members, and activity",
  },
  "/admin/clans/chat-history": {
    title: "Chat History",
    description: "Review clan chat messages and moderation logs",
  },
  "/admin/clans/blocked-clans": {
    title: "Blocked Clans",
    description: "Manage clans blocked from the system",
  },
  "/admin/clans/search-topics": {
    title: "Search Topics",
    description: "Search and manage clan topics/tags",
  },
};

export default function Header() {
  const pathname = usePathname();
  const current =
    pageInfo[pathname] || { title: "Unknown Page", description: "" };

  const isDashboard = pathname === "/admin";
  const isLearnerList = pathname === "/admin/users/learners";
  const isCreatorPage = pathname === "/admin/users/creators";
  const isViolationPage = pathname === "/admin/users/violations";
  const isLessonsPage = pathname === "/admin/learning/units";
  const isQuestionsPage = pathname === "/admin/learning/questions";
  const isImportExportPage = pathname === "/admin/learning/import-export";
  const isTagsPage = pathname === "/admin/learning/tags";
  const isClanListPage = pathname === "/admin/clans/clan-list";
  const isChatHistoryPage = pathname === "/admin/clans/chat-history";
  const isBlockedClansPage = pathname === "/admin/clans/blocked-clans";
  const isSearchTopicsPage = pathname === "/admin/clans/search-topics";

  return (
    <header
      className="
        w-full sticky top-0 z-40
        px-6 py-4 
        bg-white/80 backdrop-blur-xl
        border-b border-gray-100
        flex items-center justify-between
        text-gray-900
        shadow-[0_2px_8px_-3px_rgba(0,0,0,0.06)]
      "
      style={{
        WebkitBackdropFilter: "blur(14px)",
        backdropFilter: "blur(14px)",
      }}
    >

      <div className="min-w-0">
        <h1 className="text-[20px] md:text-[22px] font-semibold tracking-wide truncate">
          {current.title}
        </h1>

        {current.description && (
          <p
            className="
              text-[13px] mt-0.5 truncate font-medium
              bg-gradient-to-r from-rose-500 via-pink-500 to-purple-500 
              bg-clip-text text-transparent
            "
          >
            {current.description}
          </p>
        )}
      </div>

      {isDashboard && (
        <div className="flex items-center gap-3">
          <button
            type={"button" as const}
            className="
              px-4 py-2 rounded-full text-sm font-medium
              bg-rose-100 text-rose-600 
              border border-rose-200 
              hover:bg-rose-200 transition
            "
          >
            Live Data
          </button>

          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-rose-400 via-pink-500 to-purple-500
              text-white shadow-sm
              hover:opacity-90 transition
            "
          >
            <Download className="w-4 h-4" />
            Export Report
          </button>
        </div>
      )}


      {isLearnerList && (
        <button
          type={"button" as const}
          className="
    inline-flex items-center gap-2 text-sm font-semibold
    px-4 py-2 rounded-xl
    bg-gradient-to-r from-white via-pink-50 to-white
    text-gray-800
    border border-pink-200 shadow-sm
    hover:bg-pink-50 hover:border-pink-300
    active:opacity-80
    transition
  "
        >
          <Download className="w-4 h-4 text-pink-500" />
          Export CSV
        </button>

      )}

      {isCreatorPage && (
        <div className="flex items-center gap-3">

          {/* Soft gradient button */}
          <button
            type={"button" as const}
            className="
        inline-flex items-center gap-2 text-sm font-semibold
        px-4 py-2 rounded-xl
        bg-gradient-to-r from-white via-pink-50 to-white
        text-gray-800
        border border-pink-200 shadow-sm
        hover:bg-pink-50 hover:border-pink-300
        active:opacity-80 transition
      "
          >
            <UserPlus className="w-4 h-4 text-pink-500" />
            Review pending
          </button>

          
        </div>
      )}

       {isViolationPage && (
        <div className="flex items-center gap-3">
          {/* Primary action */}
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-rose-400 via-pink-500 to-purple-500
              text-white shadow-sm
              hover:opacity-90 transition
            "
          >
            <ShieldAlert className="w-4 h-4" />
            Moderation queue
          </button>

          {/* Secondary action */}
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-white via-pink-50 to-white
              text-gray-800
              border border-pink-200 shadow-sm
              hover:bg-pink-50 hover:border-pink-300
              active:opacity-80 transition
            "
          >
            <Download className="w-4 h-4 text-pink-500" />
            Export CSV
          </button>
        </div>
      )}

      {isLessonsPage && (
        <div className="flex items-center gap-3">
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-white via-pink-50 to-white
              text-gray-800
              border border-pink-200 shadow-sm
              hover:bg-pink-50 hover:border-pink-300
              active:opacity-80 transition
            "
          >
            <Download className="w-4 h-4 text-pink-500" />
            Export CSV
          </button>
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-pink-500 to-purple-500
              text-white shadow-sm
              hover:opacity-90 transition
            "
          >
            <Plus className="w-4 h-4" />
            Create Lesson
          </button>
        </div>
      )}

      {isQuestionsPage && (
        <div className="flex items-center gap-3">
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-white via-pink-50 to-white
              text-gray-800
              border border-pink-200 shadow-sm
              hover:bg-pink-50 hover:border-pink-300
              active:opacity-80 transition
            "
          >
            <Upload className="w-4 h-4 text-pink-500" />
            Import
          </button>
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-pink-500 to-purple-500
              text-white shadow-sm
              hover:opacity-90 transition
            "
          >
            <Plus className="w-4 h-4" />
            Create Question
          </button>
        </div>
      )}

      {isImportExportPage && (
        <div className="flex items-center gap-3">
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-white via-pink-50 to-white
              text-gray-800
              border border-pink-200 shadow-sm
              hover:bg-pink-50 hover:border-pink-300
              active:opacity-80 transition
            "
          >
            <Download className="w-4 h-4 text-pink-500" />
            New Export
          </button>
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-pink-500 to-purple-500
              text-white shadow-sm
              hover:opacity-90 transition
            "
          >
            <FileUp className="w-4 h-4" />
            New Import
          </button>
        </div>
      )}

      {isTagsPage && (
        <button
          type={"button" as const}
          className="
            inline-flex items-center gap-2 text-sm font-semibold
            px-4 py-2 rounded-xl
            bg-gradient-to-r from-pink-500 to-purple-500
            text-white shadow-sm
            hover:opacity-90 transition
          "
        >
          <Tags className="w-4 h-4" />
          Create Tag
        </button>
      )}

      {isClanListPage && (
        <div className="flex items-center gap-3">
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-white via-pink-50 to-white
              text-gray-800
              border border-pink-200 shadow-sm
              hover:bg-pink-50 hover:border-pink-300
              active:opacity-80 transition
            "
          >
            <Download className="w-4 h-4 text-pink-500" />
            Export CSV
          </button>
          <button
            type={"button" as const}
            className="
              inline-flex items-center gap-2 text-sm font-semibold
              px-4 py-2 rounded-xl
              bg-gradient-to-r from-pink-500 to-purple-500
              text-white shadow-sm
              hover:opacity-90 transition
            "
          >
            <Users className="w-4 h-4" />
            Create Clan
          </button>
        </div>
      )}

      {isChatHistoryPage && (
        <button
          type={"button" as const}
          className="
            inline-flex items-center gap-2 text-sm font-semibold
            px-4 py-2 rounded-xl
            bg-gradient-to-r from-white via-pink-50 to-white
            text-gray-800
            border border-pink-200 shadow-sm
            hover:bg-pink-50 hover:border-pink-300
            active:opacity-80 transition
          "
        >
          <MessageSquare className="w-4 h-4 text-pink-500" />
          Moderation Queue
        </button>
      )}

      {isBlockedClansPage && (
        <button
          type={"button" as const}
          className="
            inline-flex items-center gap-2 text-sm font-semibold
            px-4 py-2 rounded-xl
            bg-gradient-to-r from-pink-500 to-purple-500
            text-white shadow-sm
            hover:opacity-90 transition
          "
        >
          <Ban className="w-4 h-4" />
          Block Clan
        </button>
      )}

      {isSearchTopicsPage && (
        <button
          type={"button" as const}
          className="
            inline-flex items-center gap-2 text-sm font-semibold
            px-4 py-2 rounded-xl
            bg-gradient-to-r from-pink-500 to-purple-500
            text-white shadow-sm
            hover:opacity-90 transition
          "
        >
          <Hash className="w-4 h-4" />
          Create Topic
        </button>
      )}

      {!isDashboard && !isLearnerList && !isCreatorPage && !isViolationPage && !isLessonsPage && !isQuestionsPage && !isImportExportPage && !isTagsPage && !isClanListPage && !isChatHistoryPage && !isBlockedClansPage && !isSearchTopicsPage && (
        <div className="relative w-10 h-10 opacity-90">
          <Image
            src="/images/brainbattle_logo_really_pink.png"
            alt="BrainBattle Logo"
            fill
            className="object-contain"
          />
        </div>
      )}
    </header>
  );
}
