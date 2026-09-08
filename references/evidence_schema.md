# Evidence and knowledge schemas

Use stable IDs: `S###` sources, `E###` evidence, `M###` methods, and `EX###` examples. IDs persist across updates; superseded records retain their IDs.

## Evidence record

Required fields:

```yaml
evidence_id: E001
source_id: S001
locator:
  file_page: null
  printed_page: null
  slide: null
  timestamp_start: null
  timestamp_end: null
  paragraph_id: P001
speaker: teacher
evidence_type: method_selection
verbatim_excerpt: ""
normalized_meaning: ""
status: confirmed
alignment: unaligned
corrects: []
supersedes: []
related_method_ids: []
related_example_ids: []
uncertainty_note: null
```

Allowed evidence status: `confirmed`, `ambiguous`, `incomplete`, `corrected`. Allowed alignment: `confirmed`, `candidate`, `unaligned`. At least one real locator is required. Empty locator fields remain `null`.

## Method record

Each method records its teacher-given name or a clearly marked editor name, problem goal, recognition signals, required and exclusion conditions, selection rationale, supported alternatives, ordered steps with reasons, pivotal step, boundaries, failure modes, checks, mistakes, examples, evidence IDs, and explicit unknowns.

A teacher-specific value without an evidence ID is invalid. General verification or an editor's explanation goes under `supplement`.

## Example record

Each example stores the prompt, conditions, target, notation, teacher's steps and reasons, visual dependencies, wrong attempts, correction sequence, final result, verification status, method IDs, and evidence IDs.

## Knowledge index

`KNOWLEDGE_INDEX.md` maps topics and problem signals to method, example, and evidence IDs. Include aliases so a user's wording can find the teacher's terminology.

## Claim identity

- `teacher-supported`: direct evidence.
- `teacher-method-transfer`: derived for a new problem from supported method conditions and steps.
- `supplement`: useful material without evidence that the teacher taught it.

Do not label absence from the available material as outside the syllabus without separate evidence.
