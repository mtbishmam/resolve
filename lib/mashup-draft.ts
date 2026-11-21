import { readPracticeNoteFields, type PracticeNotes } from "./practice-notes";

export const mashupDraftKey = (id: string) => `resolve.mashup-draft.v1:${id}`;

export type MashupDraft = {
  activeProblemId?: string;
  notes: Record<string, PracticeNotes>;
};

export function parseMashupDraft(
  raw: string | null,
  problemIds: string[],
): MashupDraft {
  if (!raw) return { notes: {} };
  try {
    const parsed = JSON.parse(raw) as Partial<MashupDraft>;
    const notes = Object.fromEntries(
      problemIds.flatMap((id) => {
        const valid = readPracticeNoteFields(parsed.notes?.[id]);
        return Object.keys(valid).length ? [[id, valid]] : [];
      }),
    );
    return {
      activeProblemId:
        parsed.activeProblemId && problemIds.includes(parsed.activeProblemId)
          ? parsed.activeProblemId
          : undefined,
      notes,
    };
  } catch {
    return { notes: {} };
  }
}
