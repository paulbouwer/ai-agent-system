# Decision Record: Index Files for Optimised Agent Knowledge Exchange

- **Status:** Accepted
- **Deciders:** Paul Bouwer
- **Date:** 03 February 2026
- **Related Docs:** [Agent Architecture Decision](2026-02-03-agent-architecture-skills-standards-separation.md), [Standards Index](../../agent-system/standards/standards.index.md), [Decision Records Index](decision-records.index.md)

## Summary (Y-Statement)

_**In the context of**_ AI agents needing to discover and load relevant knowledge from the agent-system,
_**facing**_ token limits and the inefficiency of scanning folders and reading multiple files,
_**we decided**_ to implement index files as curated entry points with summaries and paths to detailed content,
_**to achieve**_ efficient, tiered knowledge loading where agents can scan summaries before selectively loading full documents,
_**accepting**_ that index files must be maintained in sync with their referenced content.

## Context

AI coding agents operate within context window limits and are charged by token usage. When an agent needs to apply standards or reference decisions, it faces a choice:

1. **Load everything** — Wasteful; fills context with potentially irrelevant content
2. **Scan folders and read files** — Multiple tool calls; slow and token-inefficient
3. **Use an index** — Single file scan; selective loading based on relevance

The agent architecture (see [related decision](2026-02-03-agent-architecture-skills-standards-separation.md)) emphasises isolated context for optimal token usage. Index files are a mechanism to enable this principle at the knowledge layer.

**Problem with previous approach:** Agents were left to scan folders and read files to discover content. This resulted in:

- Multiple tool calls to list directories and read files
- Loading irrelevant content into context
- No summary-level information for relevance matching
- Inefficient use of tokens and time

## Decision

Implement index files as curated entry points for knowledge domains:

### Index File Pattern

```text
<domain>/
├── <domain>.index.md    # or index.md / standards.index.md
├── content-a.md
├── content-b.md
└── subfolder/
    └── content-c.md
```

### Index File Structure

Each index file provides:

1. **Purpose statement** — What this index covers
2. **Usage guidance** — How to use the index (when to load what)
3. **Content summary table** — Path, description, and key information for each item
4. **Routing hints** — Which content applies to which tasks

### Current Index Files

| Index | Location | Purpose |
| ----- | -------- | ------- |
| Standards Index | `agent-system/standards/standards.index.md` | Entry point for all shared standards |
| Decision Records Index | `project/decision-records/decision-records.index.md` | Quick reference with Y-Statement summaries |

### Tiered Loading Pattern

Index files enable a tiered approach to knowledge loading:

```text
Tier 1: Scan index
        ├── Summary sufficient? → Use summary, done
        └── Need detail? → Continue to Tier 2

Tier 2: Load specific file(s)
        └── Full content for detailed work
```

**Example with Decision Records:**

1. Agent scans `decision-records.index.md`
2. Y-Statements provide enough context to identify relevant decisions
3. If Y-Statement answers the question → no further loading needed
4. If more detail required → load only the specific decision record file

### Y-Statement as Summary

For decision records, the Y-Statement serves as an effective summary because it captures:

- **Context** — The situation/problem
- **Constraint** — The specific concern faced
- **Decision** — What was chosen
- **Outcome** — What was achieved
- **Trade-off** — What was accepted

This structured summary enables relevance matching without loading full documents.

## Consequences

### Benefits

- **Token efficiency** — Load summaries first, full content only when needed
- **Tool efficiency** — Single file read vs multiple folder scans and file reads
- **Discoverability** — Agents (and humans) can quickly find relevant content
- **Relevance matching** — Summaries enable informed decisions about what to load
- **Reduced context pollution** — Only relevant knowledge enters the context window

### Risks & Trade-offs

- **Maintenance burden** — Index files must stay in sync with content
- **Staleness risk** — Out-of-date indexes lead to missing or incorrect references
- **Additional files** — One more file to manage per domain

### Mitigation: Automated Index Maintenance

To address the maintenance burden, index files should be automatically maintained by their associated subagent and skill:

| Index | Maintaining Agent | Skill Action |
| ----- | ----------------- | ------------ |
| Decision Records Index | Decision-Record-Expert | Create and Review actions update index |
| Standards Index | *(Gap — needs guidance)* | *(Manual currently)* |

**Known gap:** The standards index is currently manually maintained. This should be addressed by adding guidance to `AGENTS.md` for maintaining the standards index when standards are added or modified.

## Alternatives Considered

### Option 1: Agent Scans Folders and Reads Files

- **Pros:** No index maintenance required; always current
- **Cons:** Multiple tool calls, loads irrelevant content, token-inefficient, slow
- **Why not chosen:** Inefficient in both token usage and tool calls; doesn't scale

### Option 2: Load Everything

- **Pros:** Simple; no decision-making required
- **Cons:** Wastes context window, degrades agent performance, expensive
- **Why not chosen:** Violates isolated context principle; impractical for larger systems

### Option 3: Folder-Level README Files

- **Pros:** Familiar pattern; co-located with content
- **Cons:** No standardised structure; doesn't provide summary-level information for relevance matching
- **Why not chosen:** README files describe the folder but don't provide the structured summaries needed for tiered loading

## Follow-up Actions

| Action | Owner | Due Date |
| ------ | ----- | -------- |
| Add standards index maintenance guidance to AGENTS.md | TBD | TBD |

## Notes

- Index files complement the agent architecture by providing a knowledge-layer mechanism for isolated context
- The pattern can be extended to other domains as the system grows (e.g., skills index, agents index)
- Consider tooling to validate index files stay in sync with referenced content

