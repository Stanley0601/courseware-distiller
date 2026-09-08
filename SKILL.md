---
name: courseware-distiller
description: Distill teacher courseware or lecture transcripts into traceable teaching evidence, methods, examples, notes, and study aids; explain new questions using the teacher's demonstrated method and its applicability boundaries. Use for 蒸馏课件、整理讲义、讲课转写整理、用老师的方法讲题、错题归因. Raw audio requires an available transcription capability.
metadata:
  version: 2.0.0
---

# Courseware Distiller

Build a traceable model of what the teacher taught, especially how the teacher recognizes a problem, chooses a method, carries it out, checks it, and decides when it does not apply. Then derive notes or explanations from that evidence.

## Route the request

- **Distill:** read [references/source_processing.md](references/source_processing.md), [references/evidence_schema.md](references/evidence_schema.md), and [references/methodology.md](references/methodology.md).
- **Teach a question:** read [references/teaching_workflow.md](references/teaching_workflow.md) and [references/teacher_persona.md](references/teacher_persona.md). Also load the relevant method, example, and evidence records; `TEACHER_PROFILE.md` alone is insufficient.
- **Update an existing course:** additionally read [references/incremental_update.md](references/incremental_update.md).
- **Create cards:** additionally read [references/card_spec.md](references/card_spec.md).
- **Analyze a mistake:** additionally read [references/mistake_book.md](references/mistake_book.md).
- **Create review reminders:** read [references/review_schedule.md](references/review_schedule.md) only when the user asks for reminders or a review schedule.

## Input boundary

Accept PDF, PPT/PPTX, Markdown, text, subtitles, and existing transcripts through available extraction tools. For raw audio, first verify that the current environment actually has transcription capability. If it does not, ask for a transcript and continue with any other usable material. Never imply that reading an audio filename means its speech was transcribed.

Before distilling, assess extraction completeness. Preserve negation, conditions, corrections, speaker identity, formulas, and references to slides or board work. Mark missing or ambiguous material instead of reconstructing it from general knowledge.

## Course store

Write derived files below a course directory chosen from the source title or the user's location:

```text
{course}/
|-- COURSE_MANIFEST.md
|-- SOURCE_MAP.md
|-- TEACHER_PROFILE.md
|-- KNOWLEDGE_INDEX.md
|-- sources/       normalized source text with stable locators
|-- evidence/      traceable teaching evidence
|-- methods/       recognition, selection, steps, boundaries
|-- examples/      teacher-worked examples and corrections
|-- NOTES.md / CARDS.md / MINDMAP.md / STUDY_GUIDE.md / MISTAKES.md
```

Do not copy large originals unless the user asks. Record their path and hash in `COURSE_MANIFEST.md`. Use the templates in `assets/templates/`.

## Non-negotiable distinctions

Keep these three identities separate:

1. **Teacher-supported:** directly supported by a source and locator.
2. **Teacher-method transfer:** a new conclusion obtained by applying a supported method to a new problem.
3. **Supplement:** useful material not established as the teacher's method.

Missing evidence remains `unknown`; do not fill a template by inventing the teacher's rationale, voice, method boundary, page, timestamp, or quote. “Not stated in the material” is not automatically “outside the syllabus.”

## Distill outcome

Build evidence, method, and example records before compressing them into notes. The evidence store keeps relevant teaching detail; summaries may be concise. Check fidelity, completeness, and locatability rather than discarding a fixed percentage of content.

For every reusable method, capture problem signals, required conditions, exclusions, selection rationale, steps and their reasons, alternatives, boundaries, checks, mistakes, examples, and supporting evidence. If a field is absent from the source, say so.

## Teach outcome

Before explaining a new problem, compare it with the candidate method's conditions and examples. State why the method applies or which condition fails. Use the teacher's demonstrated order where supported, independently check the reasoning and answer, and label any transfer or supplement at the point where that distinction matters.

Default to one complete explanation: how to read the problem, why this method fits, the derivation, checks, pitfalls, then one focused understanding check. Use step-by-step coaching when the user asks for it or when an interactive diagnosis is useful. Do not infer motives from requests for speed or answers.

## Quality gate

Before delivery, verify:

- every claimed teacher-specific rule has a real source locator;
- corrections and student statements are not stored as the teacher's final position;
- conditions, exclusions, and unresolved references are preserved;
- new problems pass an applicability check before a method is used;
- solution correctness and teacher-method fidelity are checked separately;
- internal IDs resolve to existing records;
- unknown page numbers or timestamps remain blank;
- no user is marked as having mastered material without observable evidence.

Run `scripts/validate_skill.ps1` after editing or packaging the skill. Its structural checks do not replace a behavioral evaluation with realistic course material.
