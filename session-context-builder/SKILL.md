---
name: session-context-builder
description: Use when the user wants a concise context.md distilled from prior Codex sessions so a fresh session can inherit the important decisions, constraints, file paths, and open questions without rereading full chat history.
---

# Session Context Builder

This skill extracts reusable context from prior Codex sessions and writes a compact `context.md`.

Use it when the user wants continuity across sessions without carrying forward the entire transcript.

## Inputs

- one or more session IDs, or
- a time window such as last 1 day, last 7 days, last 30 days, last 90 days, last 365 days, or all time
- (optional) specific topic or scope to focus on within those sessions
If the user does not specify an output path, default to `context.md` in the current directory.

## Workflow

1. Read only the requested sessions from `~/.codex/sessions`.
2. Extract the durable technical context:
   - problem statement
   - key decisions
   - recurrent flows, patterns, and issues.
   - important constraints
   - relevant paths, repos, or services
   - unfinished work
   - open questions
3. Remove chatter, repetition, and temporary dead ends unless they explain an important constraint.
4. Write a concise `context.md` that a fresh Codex run can consume quickly.

## What To Preserve

- decisions that changed implementation direction
- terminology the project already uses
- boundaries the user explicitly cares about
- unresolved blockers
- assumptions that still need validation

## What To Omit

- greetings and conversational filler
- repeated reasoning that did not change the outcome, or reasoning that is not relevant to the current context
- narrow command output unless it matters later
- implementation detail that is already captured more clearly elsewhere

## Output Shape

Structure `context.md` around:

- current objective
- established facts
- key decisions
- recurrent flows, patterns, and issues
- relevant files and systems
- open questions
- next useful starting point

## Guardrails

- Do not flatten uncertainty into false confidence.
- When prior sessions disagree, call that out explicitly.
- Prefer short durable statements over long chronology.
