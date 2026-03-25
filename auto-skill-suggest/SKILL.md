---
name: auto-skill-suggest
description: Use when the user wants to mine prior Codex sessions for repeated workflows, decide which ones should become reusable skills, and optionally scaffold concise copyable skill folders from the strongest patterns.
---

# Auto Skill Suggest

This skill turns session history into candidate reusable skills.

Use it when the user has repeated similar work across many Codex sessions and wants to extract a portable skill from those repetitions.

## Inputs

- one or more session IDs, or
- a time window such as last 1 day, last 7 days, last 30 days, last 90 days, last 365 days, or all time

If the user does not specify a scope, ask for one before reading session history.

## What Makes A Good Candidate

Promote only patterns that are:

- repeated across multiple sessions
- reusable outside one codebase
- clear about inputs and outputs
- narrow enough to trigger reliably
- useful without hidden project knowledge

Reject patterns that are:

- one-off debugging sessions
- highly private or company-specific
- broad personas instead of task-shaped workflows
- better expressed as a script, template, or project note rather than a skill

## Workflow

1. Read only the requested sessions from `~/.codex/sessions`. This is further divided by <YEAR>/<MONTH>/<DAY> folders, with each jsonl file being a session.
2. Group similar tasks into repeatable workflow clusters.
3. For each cluster, identify:
   - what the user asked for
   - what artifacts were produced
   - what decisions repeated
   - what constraints repeated
4. Convert the best clusters into candidate skills.
5. For each candidate, state:
   - suggested skill name
   - trigger phrases
   - required inputs
   - expected outputs
   - why this should be a skill
   - why it should not be a script-only utility
6. Rank the candidates by portability and usefulness.

## If The User Wants Skill Creation

When asked to materialize the best candidates:

1. Create one folder per accepted skill.
2. Prefer a single `SKILL.md` file first.
3. Add `references/`, `assets/`, or `scripts/` only if the skill clearly needs them.
4. Keep the result self-contained and copyable.

## Output Shape

When suggesting skills, use this shape:

- `name`
- `why it repeats`
- `who can reuse it`
- `trigger`
- `inputs`
- `outputs`
- `skill or not`
- `notes on scope`

When creating skills, keep them concise and opinionated. Avoid turning one skill into a general framework.
