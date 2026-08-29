---
name: coding
description: Principles for writing and designing code, covering API and abstraction design, naming, comment discipline, and standards of evidence for claims about code behavior. Use whenever the task is to write or modify code, design an API or software architecture, or review code.
---

# Coding

These principles are language-agnostic: they say what to aim for, and each language has its own purpose, philosophy, and abstraction tools for getting there. Express them through what the language actually offers; where a facility is missing, use the idiom its community has settled on, which may legitimately be a comment or a naming convention. Nothing below justifies fighting the language's grain. The same holds for a project's conventions: take them from its best current code, not from the most common pattern, which is often just the oldest.

## Design

- Information hiding, in Parnas's sense: a module boundary is defined by the design decisions it hides, and hiding is what creates constraints a reader can rely on. What a component happens to know is not what its interface may use: "it already knows X, so using X is simpler" is precisely how implementation details leak across a boundary. Shape an interface around the abstraction its consumers need — one designed for the concept rather than for the convenience of today's single caller.
- An interface expresses domain concepts, not implementation convenience. Give each distinct operation its own precise verb rather than a catch-all verb. Where the domain says states are exclusive, make illegal states unrepresentable; prefer structure that makes misuse inexpressible over discipline that forbids it.
- Don't open with generalities; refine stepwise. Derive each fact where it is first used, even at the cost of repeating a short derivation. Extract functions for stepwise refinement and conceptual abstraction, not for deduplication; tolerate structural duplication between distinct intentions.
- Assert an invariant at the existing boundary where it holds: the constructor that makes it true, the accessor that already requires it. Don't introduce a parallel entry point that callers must remember to choose. When you add surface only so a checker can see what the code already guarantees, you turn a structural property into caller discipline. Taking in what a callee cannot know on its own (a capacity, a batch size, a precondition only the caller can vouch for) is a different, legitimate design decision.

## Naming

- Watch for over-naming: a named type declares a conceptual boundary, so don't mint one for an implementation detail. Prefer parameterizing by an existing concept over introducing an alias that adds no constraint.
- Name, return shape, and call-site usage should agree: a function every caller uses as a predicate should be a predicate.
- A name that refuses to come is a smell in the decomposition, not a thesaurus problem.

## Comments

A comment is an unchecked claim: nothing verifies it, and nothing forces it to evolve with the code. First, treat the urge to write one as a signal about the code. Try to move the content into something the language checks or names: a type, a better name, an extracted function, a named constant, an assertion, a test. What survives that attempt is the legitimate residue:

- Rationale: why this design over the alternatives; constraints, non-obvious domain rules, upstream quirks that no naming can carry.
- Obligations beyond the type system (safety conditions, ordering or aliasing invariants), stated as precise propositions in the ecosystem's conventional form.

Never narrate control flow or restate the code at its own abstraction level. Doc comments are prose documentation of an API, not an escape hatch; a contract left in doc prose when the language could enforce it is formalization debt.

Two cautions. Never delete a comment while leaving the code cryptic; relocate the information instead. And notice that the urge to write a long comment grows exactly where confidence is low: resolve the uncertainty or surface it as a question; don't pad.

## Claims about code behavior

Explaining a result and justifying it are different activities. When the question is why code behaves as it does (a benchmark, a bug, an anomaly), the deliverable is the mechanism, not a story consistent with the outcome. Consistency is a weak filter: many candidate mechanisms fit any given result. A candidate earns belief by surviving attempts to rule it out (via domain knowledge, elimination, or a changed experiment), not by fitting the numbers. If being challenged makes you swap to a different mechanism with the same confidence, you were justifying, not investigating.

Keep verified observation and hypothesis explicitly separate, and mark that status in the first draft, not after being challenged. "Probably X, and X is hard to measure directly" is an honest, acceptable conclusion; a confident mechanism that merely fits is not. A deliverable states only what is currently believed true, with no history of retracted claims.

When writing about changes (changelog, PR summary), read each commit's full diff and message body. Never let a qualified claim read as an unqualified one, and name only public API in user-facing prose.

## Style

- Declare variables immediately before use and minimize their scope; a block's declarations should read as a summary of its data flow.
- Write comments, documentation, and commit messages in English unless the project says otherwise.
