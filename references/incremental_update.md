# Incremental update and legacy migration

## Detect changes

Compare source path, size, and SHA-256 against `COURSE_MANIFEST.md`. Classify the event as new material, source replacement, correction, or recovered missing context. Do not assume that a same-named file is unchanged.

Preserve stable knowledge IDs. Use `supersedes` and `corrects` links for changed claims. Mark dependent methods, examples, and derived study products for review.

## Merge rules

- Add truly new chapters without renumbering existing records.
- When new evidence changes an earlier claim, retain both records and identify the current supported position.
- Keep conflicting accounts separate until resolved.
- Rebuild affected summaries and indexes; do not silently append contradictory text.
- Record update date, source hash, affected IDs, and unresolved work in the manifest.

## Legacy courses

When an older course contains only `TEACHER_PROFILE.md` or summaries, record the legacy version, preserve old files or make a recoverable backup, import claims as `source-pending` navigation items, reconstruct evidence if originals exist, and restrict teacher attribution if they do not. Never invent citations to make a legacy profile appear validated.
