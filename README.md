This repo contains copyable, plugable Codex skills, that I have found useful in my work, will keep adding and updating as per usage.

Each skill folder is structured for three audiences:

- `SKILL.md` is the agent-facing source of truth
- `agents/openai.yaml` provides UI and invocation metadata
- `README.md` is the human-facing summary

Current skills:

- `auto-skill-suggest`
- `feature-scaffold-from-session`
- `project-skeptic`
- `reverse-design-doc`
- `session-context-builder`

Use codex_install_skill.sh with any of the skill-directory links in this repo or any repo!
With no flag just to download, --help to add it to ./.codex/skills/ , --global to add it to ~/.codex/skills/
