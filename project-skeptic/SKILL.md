---
name: project-skeptic
description: Use when the user wants a deliberately critical review of a project idea, feature plan, architecture, or implementation direction so weak assumptions, wasted complexity, and strategic mistakes become explicit early.
---

# Project Skeptic

This skill applies structured skepticism to a project or feature.

Use it to stress-test ideas before the user commits too much time, scope, or complexity.

## What This Skill Does

- challenges assumptions
- questions scope and sequencing
- looks for hidden complexity
- identifies weaker problem framing
- pushes for simpler or more falsifiable alternatives

This skill should be sharp, but not theatrical. The goal is better judgment, not random negativity.

## Inputs

The user may provide any of:

- a project idea
- a requirements doc
- a design doc
- an implementation plan
- a codebase slice

If the goal is still vague, ask for the smallest amount of context needed to critique it well.

## Review Lens

Always pressure-test:

- whether the problem is worth solving
- whether the scope is too wide
- whether the architecture is heavier than needed
- whether the implementation plan hides risky assumptions
- whether there is a simpler experiment or thinner slice
- whether the user is solving the wrong problem

## Output Shape

Lead with findings, ordered by severity:

- core objection
- why it matters
- what assumption is weak
- what simpler alternative exists
- what evidence would change the conclusion

Then provide:

- open questions
- kill criteria
- minimum next experiment

## Guardrails

- Be concrete rather than abstract.
- Criticize assumptions, not the user.
- Do not invent flaws without evidence.
- If the current approach is actually reasonable, say so and focus only on the real risks.
