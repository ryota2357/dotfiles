---
name: coding
description: Principles for writing, changing, and testing code, covering readability at every scale, abstraction and naming, interfaces, comments and documentation, tests as maintained code, and standards of evidence for claims about code behavior.
---

# Coding

These principles apply in any language. Express each one with the abstraction the language provides, or, where it has none, with the idiom its community uses. Where a project's conventions conflict with each other, follow the ones it is moving toward rather than the most common ones, which are often just the oldest. Write comments, documentation, and commit messages in English unless the project uses another language for them.

## Code is read

A program is executed for its effect, but it is also a text, and most of its cost lies in being read and changed. Readers understand code by predicting what comes next, and they take everything present as meaningful: a branch that handles a case implies the case can occur, a declaration implies the value is about to be used, a separate function implies a separate concept, a comment implies something the code could not say. Write so that these implications hold. Good code makes a complex problem look straightforward: each routine turns out to do roughly what the reader expected, and each line follows from the ones before it.

Complex behavior becomes readable when it is broken into steps that are each simple at their own level, and functions and types exist to create those levels. Introduce a function or a type when it gives a name and a precise meaning to a step or a concept, so that the code using it reads at a higher level. Repeated code is not in itself a reason to abstract, and code that looks similar but means different things should stay separate.

Design decisions like these are made at every scale, from a module boundary down to a single expression. A variable's scope is the smallest instance of information hiding: declare the variable where it is first needed and keep its scope as narrow as the data flow allows. A name is the smallest interface: it says what the thing is or does in the domain's terms, and mentions how it is implemented only when callers may rely on that. When no good name comes to mind, the decomposition is usually wrong.

## Interfaces

A module, a type, or a function is defined by the design decisions it hides, in Parnas's sense of information hiding, and its interface by the behavior it promises. Build only on what an interface promises. Reasoning that some code "already knows X, so using X is simpler" is how implementation details leak across a boundary. Shape an interface around the concept its callers need rather than around the convenience of the caller at hand, and where states are mutually exclusive in the domain, make the illegal ones unrepresentable.

A second entry point to an operation is justified only by a contract that differs from the first, and its name states that difference. A faster implementation of the same contract should replace the original rather than sit beside it. When a compiler, optimizer, or verifier cannot see an invariant the code already guarantees, tell it directly, with a type, a checked assertion, or, failing those, an unchecked hint, rather than contorting the implementation or adding an entry point that turns the guarantee into an obligation on callers.

## Comments and documentation

Ideally, the code states its own intent, and comments carry what it cannot: the reason for a choice that is not the obvious one, domain or business rules, constraints imposed from outside the code, invariants beyond the type system, and layouts or algorithms that are clearer as a picture (ASCII diagrams are fine). Write a comment for whoever opens the file next, who knows nothing about your session. A comment explains the code as it stands; the discussion that produced it, what the code used to do, and the change you just made belong outside the code, in the commit message or your report.

Doc comments are documentation, and whether to write one depends on who reads it rather than on visibility. A library's users read its documentation instead of its source, so there the documentation is part of the deliverable: document the public API thoroughly, with the ecosystem's conventional sections and examples. Where readers read the source, write a doc comment only when they need something the signature and the code cannot tell them. In both cases, express a constraint in types or structure where possible, and state it in prose only as a last resort or where the language's conventions call for it, as with Rust's `# Safety` and `# Panics` sections. Describe what a caller can observe, not how it is achieved.

## Tests

Tests are software too. They are read, maintained, and changed along with the code, and the principles above apply to them. A suite is the specification of behavior written as code, so choose and organize cases by the distinctions the specification makes (its boundaries and the cases it treats differently) rather than by listing every input you can think of or by the order in which changes and bugs arrived. Name each test for the behavior it pins down. Test through the interface, so that changing internals does not require changing tests.

## Changing code

Change code strategically, in Ousterhout's sense: when the change is done, the code should look as if it had been designed with the change in mind from the start. The request decides what behavior changes. The code decides how much must change for the result to be coherent: rename anything whose meaning the change altered, update the callers of an internal API instead of preserving its old shape, turn a special case that exposes a missing concept into that concept, delete what the change left unused, and rewrite the comments, documentation, and tests that no longer describe the intended behavior rather than adjusting them just enough to match the code. Instructions to keep a change focused limit which behaviors change, not how well the change is integrated. Follow the project's conventions, but treat its existing structure as something the change may need to reshape.

Ask the user when a coherent change would extend well beyond what the request implies, when the request leaves the scope unclear, or when you find a pre-existing problem and it is not obvious whether to fix it now. If the answer would change the approach, ask before implementing. Treat the size of the patch as a constraint only when the user says it is one.

## Claims about code behavior

When explaining why code behaves as it does (a bug, a benchmark, an anomaly), the deliverable is the mechanism, not a story consistent with the outcome. Many mechanisms fit any given result, and a candidate earns credence by surviving attempts to rule it out, using domain knowledge or an experiment that tells the candidates apart. If being challenged makes you switch to a different explanation with the same confidence, you were justifying, not investigating. When you first state a claim, say whether you verified it or inferred it. Report what you currently believe, including what you ruled out and how, rather than the sequence of explanations you held along the way; "probably X, which is hard to measure directly" is an acceptable conclusion.
