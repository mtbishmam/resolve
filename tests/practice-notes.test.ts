import { describe, expect, it } from "vitest";
import {
  PracticeNotesSchema,
  RecordMashupResultSchema,
  UpdateMashupSchema,
} from "@/lib/contracts";
import { parseMashupDraft } from "@/lib/mashup-draft";
import { formatPracticeNotes } from "@/lib/practice-notes";

describe("durable practice notes", () => {
  const notes = {
    approaches: "Try small cases",
    lemmas: "The differences telescope",
    analysis: "Linear time",
    pattern: "Cancellation",
    memory_trigger: "Difference between opposite transitions",
    mistakes: "Tracked the whole path",
  };

  it("preserves all six fields in API, MCP and clipboard payloads", () => {
    expect(
      UpdateMashupSchema.parse({ notes_by_problem: { p: notes } })
        .notes_by_problem?.p,
    ).toEqual(notes);
    expect(
      RecordMashupResultSchema.parse({
        mashup_id: "m",
        problem_id: "p",
        ...notes,
      }),
    ).toMatchObject(notes);
    for (const value of Object.values(notes))
      expect(formatPracticeNotes(notes)).toContain(value);
  });

  it("distinguishes an omitted field from an explicit clear", () => {
    expect(PracticeNotesSchema.parse({ pattern: "" })).toEqual({ pattern: "" });
    expect(
      RecordMashupResultSchema.parse({
        mashup_id: "m",
        problem_id: "p",
        pattern: "",
      }),
    ).toEqual({
      mashup_id: "m",
      problem_id: "p",
      pattern: "",
    });
    expect(PracticeNotesSchema.safeParse({ unknown: "ignored?" }).success).toBe(
      false,
    );
    expect(PracticeNotesSchema.safeParse({ mistakes: null }).success).toBe(
      false,
    );
  });

  it("restores a same-tab draft including clears and validates membership", () => {
    const raw = JSON.stringify({
      activeProblemId: "p2",
      notes: { p1: { mistakes: "", lemmas: 4 }, p2: notes, outsider: notes },
    });
    expect(parseMashupDraft(raw, ["p1", "p2"])).toEqual({
      activeProblemId: "p2",
      notes: { p1: { mistakes: "" }, p2: notes },
    });
    expect(parseMashupDraft(raw, ["p1"]).activeProblemId).toBeUndefined();
    expect(parseMashupDraft("invalid JSON", ["p1"])).toEqual({ notes: {} });
  });
});
