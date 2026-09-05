---
name: coding
description: Principles for writing and designing code and its specification, covering API and abstraction design, naming, (doc-)comment discipline, tests, and standards of evidence for claims about code behavior.
---

# Coding

These principles are language-agnostic. They say what to aim for, and each language has its own purpose and its own abstraction tools for getting there. Express them through what the language offers, and where a facility is missing, use the idiom its community has settled on, which may legitimately be a comment or a naming convention. Take a project's conventions the same way, from its best current code. Where conventions conflict, follow the most recently revised code rather than the most common one, which is often just the oldest.

## Specification and code

Software is a specification together with an implementation. Code on its own is neither correct nor incorrect, because a system nobody has specified cannot fail, only surprise. The specification is part of the software, not an external description of it, and it is written in several places at once: types, names, assertions, doc comments, tests, and, where nothing else will hold a fact, comments. Some of those places are checked mechanically and the rest only by a reader, so where you state a given fact is a design decision. Prefer a place that is checked. When only prose can state a fact, design that prose as deliberately as the code, by giving each fact one place and making each part of a document answer a question its reader will ask.

Doc comments and tests that no longer match the code are defects in the software. Review them as you review the code.

## Design

- Information hiding, in Parnas's sense: a module boundary is defined by the design decisions it hides, and hiding is what creates constraints a reader can rely on. What a module happens to know is not what its interface may be built on. Reasoning that "it already knows X, so using X is simpler" is how implementation details leak across a boundary.
- An interface expresses domain concepts, shaped for the concept its callers need rather than for the convenience of today's single caller. Where the domain says states are exclusive, make illegal states unrepresentable, preferring structure that makes misuse inexpressible over discipline that forbids it.
- Assert an invariant at the boundary that establishes or requires it, the constructor that makes it true or the accessor that already depends on it, and don't add a parallel entry point that callers must remember to choose.
  - Even when the second entry point exists only to tell a compiler or a verifier what the code already guarantees, it converts an invariant the supplier maintained into a precondition the caller must discharge. What held by construction now holds by convention.
  - Where no other route exists, give that obligation an owner and discharge it somewhere, and mark the path that skips the check rather than leaving it indistinguishable from the checked one.
  - Taking in what a callee cannot know on its own (a capacity, a batch size, a precondition only the caller can vouch for) is a different, legitimate design decision.
- Refine stepwise rather than beginning with a general abstraction. Derive each fact where it is first used, even at the cost of repeating a short derivation. Extract functions for stepwise refinement and abstraction, not for deduplication, so tolerate structural duplication where the intentions differ. Two copies of one rule are one intention, and belong in one place.
- Declare variables immediately before use and minimize their scope, so that a block's declarations read as a summary of its data flow.

## Naming

- A name is earned by a distinction it makes: a named type declares a conceptual boundary, and an operation's name declares a promise. Where there is no distinction, the thing itself probably should not exist separately.
  - Operations: name one for its effect and purpose, never for the means by which it keeps its promise. Two entry points with the same contract are one operation under two spellings, so a second name has to be earned by a promise the first does not make. A performance property callers may rely on is such a promise, but the reason you wrote it is not. A catch-all verb is the same rule inverted, several operations under one spelling, and should be split. Name, return shape, and call-site usage should agree: a function every caller uses as a predicate should be a predicate.
  - Types and parameters: abstraction exists to create a level at which you can be precise about something you could not state before, so a name that constrains no values and hides no decision has created no such level. Before binding values that travel together into a type, delete one of them and see what happens to the rest. If they stop making sense, an invariant relates them and the type is real. If they carry on unaffected, you have a tuple. Take names from the language the domain already speaks, not from the shorthand of your working session.
- When no good name comes, the fault is in the split rather than your vocabulary, so change the decomposition instead of the word.

## Comments and docs

A comment states part of the specification in the one place nothing can check, and nothing forces it to evolve with the code. So first, treat the urge to write one as a signal about where the fact belongs. Try to move it into something the language checks or names: a type, a better name, an extracted function, a named constant, an assertion, a test. What survives that attempt is the legitimate residue:

- Rationale: why this design over the alternatives, and the constraints, non-obvious domain rules, or upstream quirks that naming alone cannot capture.
- Obligations beyond the type system (safety conditions, ordering or aliasing invariants), stated as precise propositions in the ecosystem's conventional form.

A doc comment is not this residue. It is the interface specification, owed to callers whether or not some other construct could have stated it. What it owes them is the externally visible behavior: what they must establish before calling, what they may rely on afterwards, and what the call costs them. The internal representation that produced a value belongs to the module's internal design, and naming it in the doc comment leaks what the interface exists to hide. A detail the caller cannot act on is padding. An obligation left in prose that the language could enforce is formalization debt.

Two cautions:

- Never delete a comment while leaving the code cryptic. Relocate the information instead.
- Because the urge to write a long comment grows where confidence is low, resolve the uncertainty or raise it as a question rather than padding.

## Prose about code

Prose about code fails in three ways, each of them the writer intruding on the reader:

- Stream of consciousness: a fact lands wherever the author happened to think of it.
- Stream of execution: the prose retells the code in the code's own terms, at the same level of abstraction.
- Myopia: it records the details you are afraid of forgetting and passes over the design decisions you have lived with too long to notice.

Write for whoever opens the file next, knowing none of what you know now, rather than for whoever reads today's diff. Prose that reaches users names only the public API.

Reach for the concept the field has already named rather than the case you happened to meet, because examples encode only the cases you have seen, and a reader will generalize them into cases where they do not hold. An example is there to fix the meaning of a stated principle, never to carry it.

Write comments, documentation, and commit messages in English unless the project says otherwise.

## Tests

A test is the contract written as code: the setup establishes the precondition, the check states the postcondition, and the name states the claim. Write so that a failure names the claim that broke rather than the line that failed.

A test pins that contract at one point only, and can show the presence of a bug but never its absence, so choose the points the specification itself distinguishes: its boundaries, and the cases it treats differently. Where a claim holds for every input, an assertion or a property states it once instead of sampling it repeatedly.

Test through the interface, not the representation. A test that has to change whenever the internals change was written on the wrong side of the boundary.

## Claims about code behavior

Investigation and justification are different activities. When the question is why code behaves as it does (a benchmark, a bug, an anomaly), the deliverable is the mechanism, not a story consistent with the outcome. Consistency is a weak filter, since many candidate mechanisms fit any given result. A candidate earns belief by surviving attempts to rule it out, whether by domain knowledge, by elimination, or by an experiment chosen to tell candidates apart. If being challenged makes you swap to a different mechanism with the same confidence, you were justifying, not investigating.

Keep verified observation and hypothesis separate, and label each claim in the first draft, not after being challenged. "Probably X, and X is hard to measure directly" is an honest, acceptable conclusion; a mechanism asserted with confidence because it fits is not. A deliverable states only what is currently believed true, and does not narrate the claims you retracted along the way.

When writing about changes (changelog, PR summary), read each commit's full diff and message body, and never let a claim the commit qualified read as an unqualified one.
