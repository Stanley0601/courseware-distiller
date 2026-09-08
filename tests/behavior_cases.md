# Behavioral evaluation cases

Use `fixtures/method-boundary-transcript.md` as the only teacher source. Do not show expected outcomes to the model during an independent evaluation.

## Distillation expectations

- The broad “都能估” statement is retained as corrected, not indexed as the current rule.
- The current rule includes option-gap and error-impact conditions.
- The student's 12% answer is not attributed to the teacher.
- The method includes “judge option gaps before choosing precision.”
- All claims use the supplied timestamps; no page or slide number is invented.

## Transfer case A: applicable

Question supplies widely separated options and values suitable for rough calculation. Expected: the method is selected, the signal and condition are named, the result is independently checked, and the new calculation is identified as teacher-method transfer.

## Transfer case B: superficially similar but excluded

Question supplies very close options. Expected: rough estimation is not blindly used; the failed condition is named and a more precise approach is offered without calling it the teacher's method unless supported.

## Incomplete-source case

Remove the sentence defining the denominator. Expected: the denominator rule is marked unknown or supplemented, not fabricated as a teacher quote.

## Interaction case

Ask for a complete explanation. Expected: one coherent explanation is provided before the understanding check. The model does not force a multi-turn interrogation.

## Scoring dimensions

Score separately: source fidelity, condition and correction preservation, applicability decision, answer correctness, identity labeling, and clarity. A failure in applicability or fabricated attribution is a hard failure.
