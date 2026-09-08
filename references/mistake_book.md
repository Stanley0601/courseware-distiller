# Mistake analysis

Use this mode when the user supplies a wrong answer or reasoning process. If only the question is available, explain the problem but do not invent an error cause. Ask for the user's work only when attribution is requested and it is unavailable.

## Attribution

Classify the demonstrated error as one or more of:

- **Execution:** arithmetic, reading, notation, or transcription error.
- **Strategy:** the chosen method or decision point was unsuitable.
- **Concept:** a definition, condition, relationship, or boundary was misunderstood.

Map strategy and concept errors to method and evidence IDs. Load the relevant method, example, and source evidence before claiming how the teacher would handle the decision.

## Explanation and variants

Follow `teaching_workflow.md`, including the applicability record and separate correctness/fidelity checks. Prefer a relevant course exercise when available. A newly written isomorphic question is `teacher-method-transfer` when it uses a supported method; it is not automatically outside the syllabus. Any rule or technique absent from the course evidence is a `supplement`.

Respect the user's requested interaction style. A user may ask for a full correction, a hint, or guided practice. Do not withhold a requested explanation merely to force participation.

## Recording and review

Append one record per mistake to `MISTAKES.md`. Preserve the user's actual work, attribution evidence, relevant method and example IDs, correction, practice, and review state. Do not mark an item mastered unless the user demonstrates the method on a later attempt or gives an adequate explanation.

Suggested states are `new`, `D3 review`, `W1 review`, and `mastered`; scheduling is optional and follows `review_schedule.md` only when relevant.
