import {
  PRACTICE_NOTE_FIELDS,
  PRACTICE_NOTE_LIMIT,
  type PracticeNoteField,
  type PracticeNotes,
} from "@/lib/practice-notes";

export default function PracticeNoteFields({
  notes,
  onChange,
  disabled,
}: {
  notes: PracticeNotes;
  onChange: (field: PracticeNoteField, value: string) => void;
  disabled?: boolean;
}) {
  return PRACTICE_NOTE_FIELDS.map(([field, label, placeholder]) => (
    <label key={field}>
      <span>{label}</span>
      <textarea
        value={notes[field] ?? ""}
        placeholder={placeholder}
        onChange={(event) => onChange(field, event.target.value)}
        maxLength={PRACTICE_NOTE_LIMIT}
        disabled={disabled}
      />
    </label>
  ));
}
