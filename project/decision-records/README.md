# Decision Records

This folder contains architectural decision records (ADRs) documenting significant decisions made for this project.

## Purpose

Decision records capture the context, rationale, and consequences of important technical and architectural decisions. They serve as:

- **Historical documentation** — Why decisions were made
- **Onboarding aid** — Help new contributors understand the project
- **Change management** — Track evolution of architecture over time

## Structure

```text
project/decision-records/
├── README.md                           # This file
├── YYYY-MM-DD-short-description.md     # Active decision records
└── deprecated/                         # Deprecated or superseded records
```

## Creating Decision Records

Use the **Decision-Record-Expert** agent to create or review decision records:

```text
create a decision record for <topic>
review the following decision record <decision-record-file>
```

The agent guides you through Socratic discovery to ensure decisions are well-understood before documentation, and automatically maintains the [decision-records.index.md](decision-records.index.md).

### Quick Reference

| Item | Rule |
| ---- | ---- |
| **Filename** | `YYYY-MM-DD-short-description.md` (lowercase, hyphens) |
| **Initial Status** | `Proposed` |
| **Required** | Y-Statement summary, context, decision, consequences, alternatives |

## Status Lifecycle

| Status | Description |
| ------ | ----------- |
| **Proposed** | Under discussion; not yet approved |
| **Accepted** | Approved and should be followed |
| **Deprecated** | No longer recommended; moved to `deprecated/` |
| **Superseded** | Replaced by newer decision record (link to replacement) |

## Index

See [decision-records.index.md](decision-records.index.md) for a quick reference of all decision records with their status and Y-Statement summary.
