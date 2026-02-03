# Review Decision Record

## Purpose

Analyse an existing decision record for completeness, quality, and standards compliance, then provide actionable recommendations.

---

## Flow

### Step 1: Locate Decision Record

Find the decision record to review:

| Method         | Action                                                    |
|----------------|-----------------------------------------------------------|
| User-specified | Use the file path provided by user                        |
| Search         | Look in `project/decision-records/` at repository root    |
| Recent         | List recent decision records for user to select           |

**Failure:** No decision record found → Recommend Create action

---

### Step 2: Load Standards

Load from this skill's `standards/`:

- `core.md` — Rules for naming, sections, status
- `checklist.md` — Validation criteria
- `template.md` — Expected structure

---

### Step 3: Structure Compliance Check

Evaluate against `standards/core.md` required sections:

| Section | Check |
|---------|-------|
| Title | Clear, descriptive name present |
| Metadata | Status, deciders, date, related docs |
| Summary (Y-Statement) | All five clauses present and coherent |
| Context | Background, constraints, stakeholder concerns |
| Decision | Choice stated with rationale |
| Consequences | Both benefits AND risks documented |
| Alternatives | At least one alternative with pros/cons/rejection reason |

---

### Step 4: Y-Statement Quality Check

Evaluate the Y-Statement for completeness and clarity:

```
In the context of {situation/problem},      ← Is the situation specific?
facing {specific concern or constraint},    ← Is the constraint clear?
we decided {what was chosen},               ← Is the decision concrete?
to achieve {desired outcome},               ← Is the goal measurable?
accepting {trade-off or downside}.          ← Is the trade-off honest?
```

| Priority | Issue |
|----------|-------|
| 🔴 Critical | Y-Statement missing entirely |
| 🟠 High | Clauses missing or vague |
| 🟡 Medium | Could be more specific |
| 🟢 Good | Clear and complete |

---

### Step 5: Content Quality Analysis

| Factor | Questions |
|--------|-----------|
| **Context Depth** | Does it explain WHY this decision was needed? Are constraints documented? |
| **Alternatives Quality** | Are alternatives genuinely different? Are pros/cons balanced? Is rejection reasoning clear? |
| **Consequences Honesty** | Are risks acknowledged? Are benefits realistic? |
| **Actionability** | Could someone implement based on this record? |

---

### Step 6: Naming & Metadata Check

Evaluate against `standards/core.md` naming rules:

| Rule | Check |
|------|-------|
| Date format | `YYYY-MM-DD` (ISO 8601) |
| Description | Lowercase, hyphens, 3-7 words |
| No spaces/underscores | Filename uses hyphens only |
| Status valid | One of: Proposed, Accepted, Deprecated, Superseded |

---

### Step 7: Generate Findings Report

Categorise findings by priority:

| Priority | Category | Examples |
|----------|----------|----------|
| 🔴 Critical | Missing required elements | No Y-Statement, no alternatives, no consequences |
| 🟠 High | Standards violations | Wrong naming format, missing metadata, incomplete sections |
| 🟡 Medium | Quality improvements | Vague context, weak rationale, unclear trade-offs |
| 🟢 Low | Enhancements | Additional context, more alternatives, follow-up actions |

---

### Step 8: Present Results

Provide:

1. **Overall Score** — Completeness score (X/10)
2. **Critical Issues** — Problems that must be fixed
3. **Compliance Gaps** — Standards violations with specific fixes
4. **Quality Improvements** — Suggestions to strengthen the record
5. **Commendations** — What the record does well

---

## Scoring Methodology

| Category | Weight | Calculation |
|----------|--------|-------------|
| Required Sections | 30% | (present / 7 required sections) × 100 |
| Y-Statement | 25% | (complete clauses / 5) × 100 |
| Alternatives | 20% | At least 1 = 50%, 2+ with detail = 100% |
| Consequences | 15% | Benefits = 50%, Risks = 50% |
| Naming & Metadata | 10% | Filename + status + date + deciders |

**Score Interpretation:**

| Score | Rating | Action |
|-------|--------|--------|
| 9-10 | Excellent | Ready for acceptance |
| 7-8 | Good | Minor improvements recommended |
| 5-6 | Adequate | Should address gaps before accepting |
| 3-4 | Needs Work | Significant revisions required |
| 0-2 | Incomplete | Return to Create flow |

---

## Output Format

```text
═══════════════════════════════════════════════════════════
📋 DECISION RECORD REVIEW
═══════════════════════════════════════════════════════════
File: {filename}
Score: {X}/10 ({rating})

🔴 CRITICAL ISSUES
- {issue with specific fix}

🟠 COMPLIANCE GAPS
- {gap with reference to standard}

🟡 QUALITY IMPROVEMENTS
- {suggestion}

🟢 COMMENDATIONS
- {what's done well}

═══════════════════════════════════════════════════════════
```

---

## Index Maintenance

When a decision record's status changes, update `project/decision-records/decision-records.index.md`:

### Status Update (Proposed → Accepted)

Update the status column in the **Active Records** table.

### Deprecation (→ Deprecated or Superseded)

1. Move the decision record file to `project/decision-records/deprecated/`
2. Remove the entry from **Active Records** table
3. Add entry to **Deprecated Records** table with:
   - File path pointing to `deprecated/` folder
   - Status (`Deprecated` or `Superseded`)
   - Y-Statement
   - Superseded By (link to replacement record, if applicable)
