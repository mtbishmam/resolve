export const PRACTICE_NOTE_FIELDS = [
  ["approaches", "Approaches", "Approaches tried or considered…"],
  ["lemmas", "Lemmas", "Useful observations and lemmas…"],
  ["analysis", "Analysis", "Reasoning, complexity, or failure analysis…"],
  ["pattern", "General pattern", "What reusable technique applies?"],
  [
    "memory_trigger",
    "Memory trigger",
    "What clue should make me recognize it?",
  ],
  ["mistakes", "Mistakes", "Where did I get stuck or take a detour?"],
] as const;

export const PRACTICE_NOTE_LIMIT = 50_000;
export type PracticeNoteField = (typeof PRACTICE_NOTE_FIELDS)[number][0];
export type PracticeNotes = Partial<Record<PracticeNoteField, string>>;

export function readPracticeNoteFields(value: unknown): PracticeNotes {
  if (!value || typeof value !== "object") return {};
  const notes = value as Record<string, unknown>;
  return Object.fromEntries(
    PRACTICE_NOTE_FIELDS.flatMap(([field]) => {
      const text = notes[field];
      return typeof text === "string" && text.length <= PRACTICE_NOTE_LIMIT
        ? [[field, text]]
        : [];
    }),
  );
}

export function formatPracticeNotes(notes: PracticeNotes) {
  return PRACTICE_NOTE_FIELDS.flatMap(([field, label]) =>
    notes[field]?.trim() ? [`## ${label}\n\n${notes[field]}`] : [],
  ).join("\n\n");
}
