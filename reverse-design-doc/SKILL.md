---
name: reverse-design-doc
description: Use when the user wants a reverse-engineered design document from an existing codebase so the system structure, responsibilities, data flow, and integration points become explicit in a reusable rev-design.md artifact.
---

# Reverse Design Doc

This skill creates a design document from an existing codebase.

The output is a `rev-design.md` that helps a human or another model understand how the project actually works.

## Use This Skill When

- the code exists but the design is undocumented
- onboarding is slow
- a future implementation needs a reliable project map
- the user wants a compact architecture document grounded in code

## Input

The input is the current codebase. The user may optionally point to:

- a specific subsystem
- a service boundary
- a feature area
- a top-level app flow

If the user does not narrow the scope, start with the core runtime path and major modules.

## Workflow

1. Inspect the repository layout.
2. Identify the main entry points and execution paths. NEVER assume, ask the user if you are not sure.
3. Map major modules, ownership boundaries, and external dependencies.
4. Trace important data flow and control flow through the system.
5. Record the findings in `rev-design.md`.

## Output Requirements

`rev-design.md` should usually include:

- purpose and system overview
- major components and responsibilities
- important runtime flows
- key files, modules, and seams
- external systems and interfaces
- extension points
- risks, confusion points, or architectural debt

## Guardrails

- Base claims on code, not guesswork.
- Distinguish facts from inferred behavior.
- Prefer a useful system map over exhaustive file-by-file notes.
- Keep the document readable enough for future sessions to reuse directly.
