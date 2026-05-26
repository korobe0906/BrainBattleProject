"use client";

import { useEffect, useMemo, useState } from "react";
import { Upload, Download, Filter, Search, ChevronDown } from "lucide-react";
import { ImportRecord, ExportRecord } from "@/types/learningContent.types";
import { mockImports, mockExports } from "@/mock/learningContent.mock";

const ITEMS_PER_PAGE = 10;

export default function ImportExportPage() {
  const [tab, setTab] = useState<"import" | "export">("import");
  const [imports, setImports] = useState<ImportRecord[]>([]);
  const [exports, setExports] = useState<ExportRecord[]>([]);
  const [q, setQ] = useState("");
  const [module, setModule] = useState("All");
  const [status, setStatus] = useState("All");
  const [currentPage, setCurrentPage] = useState(1);

  useEffect(() => {
    setImports(mockImports);
    setExports(mockExports);
  }, []);

  const filteredData = useMemo(() => {
    const data = tab === "import" ? imports : exports;
    return data.filter((item) => {
      const matchesQ =
        q === "" ||
        ((tab === "import" ? (item as ImportRecord).fileName : (item as ExportRecord).exportName)
          ?.toLowerCase()
          .includes(q.toLowerCase()));

      const matchesModule =
        module === "All" || item.module === module;

      const matchesStatus =
        status === "All" ||
        (tab === "import" ? (item as ImportRecord).status : (item as ExportRecord).status) ===
          status;

      return matchesQ && matchesModule && matchesStatus;
    });
  }, [tab, imports, exports, q, module, status]);

  const totalPages = Math.ceil(filteredData.length / ITEMS_PER_PAGE);
  const paginatedData = filteredData.slice(
    (currentPage - 1) * ITEMS_PER_PAGE,
    currentPage * ITEMS_PER_PAGE
  );

  const importStatusColor = (status: string) => {
    const colors: Record<string, string> = {
      Pending: "bg-yellow-100 text-yellow-700",
      Processing: "bg-blue-100 text-blue-700",
      Success: "bg-green-100 text-green-700",
      Failed: "bg-red-100 text-red-700",
    };
    return colors[status] || "bg-gray-100 text-gray-700";
  };

  const exportStatusColor = (status: string) => {
    const colors: Record<string, string> = {
      Queued: "bg-yellow-100 text-yellow-700",
      Generating: "bg-blue-100 text-blue-700",
      Ready: "bg-green-100 text-green-700",
      Failed: "bg-red-100 text-red-700",
    };
    return colors[status] || "bg-gray-100 text-gray-700";
  };

  const formatDate = (iso: string) => {
    const d = new Date(iso);
    return d.toLocaleDateString("en-US", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    });
  };

  return (
    <div className="space-y-6">


      {/* Tabs */}
      <div className="flex border-b border-gray-200">
        <button
          onClick={() => {
            setTab("import");
            setCurrentPage(1);
          }}
          className={`px-6 py-3 font-medium border-b-2 transition ${
            tab === "import"
              ? "border-pink-600 text-pink-600"
              : "border-transparent text-gray-600 hover:text-gray-900"
          }`}
        >
          <Upload className="w-4 h-4 inline mr-2" />
          Imports
        </button>
        <button
          onClick={() => {
            setTab("export");
            setCurrentPage(1);
          }}
          className={`px-6 py-3 font-medium border-b-2 transition ${
            tab === "export"
              ? "border-pink-600 text-pink-600"
              : "border-transparent text-gray-600 hover:text-gray-900"
          }`}
        >
          <Download className="w-4 h-4 inline mr-2" />
          Exports
        </button>
      </div>

      {/* Search & Filters */}
      <div className="space-y-3">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
          <input
            type="text"
            placeholder={
              tab === "import"
                ? "Search imports by file name..."
                : "Search exports by name..."
            }
            value={q}
            onChange={(e: React.ChangeEvent<HTMLInputElement>) => setQ(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 rounded-xl border border-gray-200 bg-white text-gray-900 placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-pink-400/40"
          />
        </div>

        <div className="flex flex-wrap gap-2">
          <select
            value={module}
            onChange={(e: React.ChangeEvent<HTMLSelectElement>) => setModule(e.target.value)}
            className="px-3 py-2 rounded-xl border border-gray-200 bg-white text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-pink-400/40"
          >
            <option value="All">All modules</option>
            <option value="Lessons">Lessons</option>
            <option value="Questions">Questions</option>
            <option value="Tags">Tags</option>
          </select>

          <select
            value={status}
            onChange={(e: React.ChangeEvent<HTMLSelectElement>) => setStatus(e.target.value)}
            className="px-3 py-2 rounded-xl border border-gray-200 bg-white text-sm text-gray-700 focus:outline-none focus:ring-2 focus:ring-pink-400/40"
          >
            <option value="All">All statuses</option>
            {tab === "import" ? (
              <>
                <option value="Pending">Pending</option>
                <option value="Processing">Processing</option>
                <option value="Success">Success</option>
                <option value="Failed">Failed</option>
              </>
            ) : (
              <>
                <option value="Queued">Queued</option>
                <option value="Generating">Generating</option>
                <option value="Ready">Ready</option>
                <option value="Failed">Failed</option>
              </>
            )}
          </select>
        </div>
      </div>

      {/* Table */}
      <div className="overflow-x-auto rounded-2xl bg-white border border-gray-200 shadow-sm">
        <table className="min-w-full">
          <thead>
            <tr className="text-left text-gray-600 text-sm border-b border-gray-200">
              {tab === "import" ? (
                <>
                  <th className="px-5 py-3 font-medium">File Name</th>
                  <th className="px-5 py-3 font-medium">Module</th>
                  <th className="px-5 py-3 font-medium">Format</th>
                  <th className="px-5 py-3 font-medium">Total Records</th>
                  <th className="px-5 py-3 font-medium">Success</th>
                  <th className="px-5 py-3 font-medium">Failed</th>
                  <th className="px-5 py-3 font-medium">Status</th>
                  <th className="px-5 py-3 font-medium">Uploaded By</th>
                  <th className="px-5 py-3 font-medium">Uploaded At</th>
                </>
              ) : (
                <>
                  <th className="px-5 py-3 font-medium">Export Name</th>
                  <th className="px-5 py-3 font-medium">Module</th>
                  <th className="px-5 py-3 font-medium">Format</th>
                  <th className="px-5 py-3 font-medium">Records</th>
                  <th className="px-5 py-3 font-medium">Status</th>
                  <th className="px-5 py-3 font-medium">Requested By</th>
                  <th className="px-5 py-3 font-medium">Requested At</th>
                  <th className="px-5 py-3 font-medium">Action</th>
                </>
              )}
            </tr>
          </thead>
          <tbody>
            {paginatedData.length === 0 ? (
              <tr>
                <td
                  colSpan={tab === "import" ? 9 : 8}
                  className="px-5 py-12 text-center text-gray-500"
                >
                  No {tab} records found
                </td>
              </tr>
            ) : (
              paginatedData.map((item) =>
                tab === "import" ? (
                  <tr key={item.id} className="border-b border-gray-100 hover:bg-gray-50">
                    <td className="px-5 py-3 text-sm font-medium text-gray-900">
                      {(item as ImportRecord).fileName}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ImportRecord).module}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ImportRecord).fileType.toUpperCase()}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ImportRecord).totalRecords}
                    </td>
                    <td className="px-5 py-3 text-sm text-emerald-600 font-medium">
                      {(item as ImportRecord).successCount}
                    </td>
                    <td className="px-5 py-3 text-sm text-rose-600 font-medium">
                      {(item as ImportRecord).failedCount}
                    </td>
                    <td className="px-5 py-3">
                      <span
                        className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${importStatusColor(
                          (item as ImportRecord).status
                        )}`}
                      >
                        {(item as ImportRecord).status}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ImportRecord).uploadedBy}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {formatDate((item as ImportRecord).uploadedAt)}
                    </td>
                  </tr>
                ) : (
                  <tr key={item.id} className="border-b border-gray-100 hover:bg-gray-50">
                    <td className="px-5 py-3 text-sm font-medium text-gray-900">
                      {(item as ExportRecord).exportName}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ExportRecord).module}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ExportRecord).format.toUpperCase()}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ExportRecord).recordCount}
                    </td>
                    <td className="px-5 py-3">
                      <span
                        className={`inline-flex items-center px-2.5 py-1 rounded-full text-xs font-medium ${exportStatusColor(
                          (item as ExportRecord).status
                        )}`}
                      >
                        {(item as ExportRecord).status}
                      </span>
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {(item as ExportRecord).requestedBy}
                    </td>
                    <td className="px-5 py-3 text-sm text-gray-600">
                      {formatDate((item as ExportRecord).requestedAt)}
                    </td>
                    <td className="px-5 py-3 text-sm">
                      {(item as ExportRecord).status === "Ready" && (
                        <button
                          type={"button" as const}
                          className="text-pink-600 hover:text-pink-700 font-medium"
                        >
                          Download
                        </button>
                      )}
                    </td>
                  </tr>
                )
              )
            )}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      <div className="flex items-center justify-between bg-white px-6 py-4 rounded-lg border border-gray-200">
        <div className="text-sm text-gray-600">
          Showing {Math.max(1, (currentPage - 1) * ITEMS_PER_PAGE + 1)} to{" "}
          {Math.min(currentPage * ITEMS_PER_PAGE, filteredData.length)} of{" "}
          {filteredData.length} records
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
            {Array.from({ length: totalPages }).map((_, i) => (
              <button
                key={i}
                type={"button" as const}
                onClick={() => setCurrentPage(i + 1)}
                className={`px-2 py-1 rounded text-sm ${
                  currentPage === i + 1
                    ? "bg-pink-600 text-white"
                    : "border border-gray-200 text-gray-700 hover:bg-gray-50"
                }`}
              >
                {i + 1}
              </button>
            ))}
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
    </div>
  );
}
