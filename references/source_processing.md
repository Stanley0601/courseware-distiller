# Source processing

## Capability check

Inspect the actual source and available tools before promising extraction.

- PDF: determine whether text is embedded or OCR is needed; check pages, tables, figures, formulas, and reading order.
- PPT/PPTX: inspect slide text, speaker notes, grouped shapes, diagrams, and ordering.
- Subtitles: retain timestamps and speaker labels where present.
- Plain transcripts: assign stable paragraph IDs.
- Raw audio: use it only if a real transcription capability is available. Otherwise request a transcript.

Partial extracted text does not prove complete extraction. Record missing pages, unreadable formulas, unparsed diagrams, and absent notes in the manifest.

## Normalization rules

Allowed normalization includes punctuation, paragraph breaks, removal of semantically empty fillers, and terminology correction supported by context. Preserve negation, quantities, conditions, uncertainty, correction sequences, repeated emphasis, speaker roles, and references to visuals.

For a suspected transcription error, record raw text, proposed reading, basis, and status (`confirmed` or `ambiguous`). Never silently correct a word that changes the method or result.

## Speaker and correction handling

Distinguish teacher explanation, student question, student answer, quoted wrong solution, and narration. Link a correction to the statement it corrects. The teacher's final accepted position may be indexed as knowledge; the corrected statement remains evidence with `status: corrected`.

## Slide and transcript alignment

Align using explicit page or heading references, identical example wording or values, concept order, then slide-change cues. Set alignment to `confirmed`, `candidate`, or `unaligned`. Do not resolve “this number” or “look here” when the visual is missing. Mark the dependency and continue with unaffected material.

## Segmentation

Split long material at topic, method, example, correction, or exercise boundaries. Keep one example or derivation connected through stable IDs even if it spans chunks. Each chunk records dependencies and unfinished threads. After processing all chunks, reconcile cross-chunk definitions, corrections, and references. Do not use a fixed character limit as the only segmentation rule.
