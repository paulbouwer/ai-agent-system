# Decision Records Index

Quick reference for all decision records in this project.

## How to Use This Index

This index provides a summary of all decision records with their status and Y-Statement for quick scanning. For full details, read the linked decision record file.

**Maintained by:** The Decision-Record-Expert agent updates this index when decision records are created, updated, or deprecated.

---

## Active Records

| File | Status | Y-Statement |
| ---- | ------ | ----------- |
| [2026-02-03-devcontainer-lifecycle-hooks-architecture.md](2026-02-03-devcontainer-lifecycle-hooks-architecture.md) | Accepted | In the context of managing devcontainer lifecycle setup tasks, facing the need for composable hooks and user-specific customisations, we decided to implement a modular `.d` directory pattern with orchestrator scripts and mounted user extensions, to achieve componentised lifecycle management, accepting that users must configure their own extensions folder. |
| [2026-02-03-agent-architecture-skills-standards-separation.md](2026-02-03-agent-architecture-skills-standards-separation.md) | Accepted | In the context of enabling AI-assisted engineering across multiple repositories and AI coding agents, facing the need for isolated context management, portability, and organisational customisation, we decided to implement a three-layer architecture separating agents, skills, and standards, to achieve a portable, agent-agnostic system, accepting that users must understand the layering to navigate effectively. |
| [2026-02-03-index-files-for-optimised-agent-knowledge-exchange.md](2026-02-03-index-files-for-optimised-agent-knowledge-exchange.md) | Accepted | In the context of AI agents needing to discover and load relevant knowledge, facing token limits and inefficiency of scanning folders, we decided to implement index files as curated entry points with summaries, to achieve efficient tiered knowledge loading, accepting that index files must be maintained in sync with content. |

<!-- Template for entries:
| [YYYY-MM-DD-short-description.md](YYYY-MM-DD-short-description.md) | Proposed/Accepted | In the context of X, facing Y, we decided Z, to achieve A, accepting B. |
-->

---

## Deprecated Records

Records that are no longer recommended. Moved to `deprecated/` folder.

| File | Status | Y-Statement | Superseded By |
| ---- | ------ | ----------- | ------------- |
| _No deprecated decision records_ | | | |
