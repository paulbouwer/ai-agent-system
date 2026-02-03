# Create Decision Record

## Purpose

Guide the creation of an architectural decision record through Socratic discovery, ensuring the decision is well-understood before documentation.

---

## Flow

### Step 1: Discovery 🛑

**Goal:** Understand the real problem and decision scope before documenting anything.

Start with ONE of these questions based on context:

- "What decision are you facing? What's the core choice that needs to be made?"
- "What problem or situation is driving this decision?"
- "What will be different after this decision is made?"

After the initial response, explore:

| Area | Question |
|------|----------|
| **Stakeholders** | "Who else is affected by this decision?" |
| **Constraints** | "What constraints are you working within? (time, budget, skills, existing systems)" |
| **Success** | "How will you know if this was the right decision?" |
| **Urgency** | "What's driving the timeline for this decision?" |

**🛑 STOP**: Wait until you can articulate:
- The core decision in one sentence
- Who the decision affects
- What success looks like

**Success Criteria:**
- [ ] Core decision clearly understood
- [ ] Stakeholders identified
- [ ] Success criteria defined

---

### Step 2: Research & Options 🛑

**Goal:** Explore alternatives and gather evidence for trade-off analysis.

> ⚠️ **CRITICAL**: Only document alternatives the user actually considered. NEVER fabricate options.

**Options Exploration:**
- "What options have you already considered?"
- "What other approaches did you evaluate before deciding?"
- "Were there any options you ruled out early? Why?"

**For Each Option, Explore:**

| Dimension | Question |
|-----------|----------|
| **Benefits** | "What problems does this option solve well?" |
| **Risks** | "What could go wrong with this approach?" |
| **Effort** | "What's the implementation cost?" |
| **Reversibility** | "How hard is it to change course later?" |

**Research Tools:** When helpful, use search tools to find:
- External documentation and best practices
- Implementation patterns in public repositories
- Existing patterns in the current codebase

**🛑 STOP**: Wait until at least one alternative has been discussed with pros/cons.

**Success Criteria:**
- [ ] User has provided alternatives they considered (not invented by agent)
- [ ] Each option has benefits and risks identified
- [ ] Trade-offs between options are clear

---

### Step 3: Decision Validation 🛑

**Goal:** Build confidence in the chosen approach and construct the Y-Statement.

**Validation Questions:**
- "If you had to choose right now, what would you pick and why?"
- "What would your biggest critic challenge about this choice?"
- "What would have to change for you to reconsider?"

**Y-Statement Construction:**

Help the user articulate their decision as a Y-Statement (REQUIRED per `standards/core.md`):

```
In the context of {situation/problem},
facing {specific concern or constraint},
we decided {what was chosen},
to achieve {desired outcome},
accepting {trade-off or downside}.
```

**Example:**
> In the context of needing consistent API authentication,
> facing multiple client types with different security requirements,
> we decided to implement OAuth 2.0 with JWT tokens,
> to achieve standardised, stateless authentication across all clients,
> accepting the additional complexity of token management and refresh flows.

**🛑 STOP**: Wait until the user confirms the Y-Statement is accurate.

**Success Criteria:**
- [ ] User can state the Y-Statement clearly
- [ ] Key trade-offs are understood and accepted
- [ ] Stakeholder concerns have been addressed

---

### Step 4: Load Standards

Load from this skill's `standards/`:
- `core.md` — Rules for naming, sections, status
- `checklist.md` — Validation criteria
- `template.md` — Document structure

**Success Criteria:**
- [ ] All skill standards loaded

---

### Step 5: Pre-Documentation Check

Validate against `standards/checklist.md` before creating the file:

- [ ] Core decision is clear (Y-Statement complete)
- [ ] Context is documented
- [ ] Alternatives were provided by user (not invented)
- [ ] Consequences (benefits and risks) are identified
- [ ] Deciders are identified

**Success Criteria:**
- [ ] All pre-documentation checklist items pass

---

### Step 6: Generate Preview 🛑

Generate the complete decision record using `standards/template.md`:

1. **Filename**: `{YYYY-MM-DD}-{short-description}.md` per `standards/core.md`
2. **Location**: `project/decision-records/` at repository root
3. **Status**: Set to `Proposed` unless user specifies otherwise

Present the COMPLETE Decision Record for approval:

```
═══════════════════════════════════════════════════════════
📋 DECISION RECORD PREVIEW
═══════════════════════════════════════════════════════════
File: project/decision-records/{filename}

{Full content using standards/template.md}
═══════════════════════════════════════════════════════════

Ready to create this Decision Record? (yes/no/edit)
```

> ⚠️ **MANDATORY**: Do NOT create the file until user explicitly approves.

**🛑 STOP**: Wait for explicit user approval.

**Success Criteria:**
- [ ] Complete preview presented to user
- [ ] User has approved the content

---

### Step 7: Create File

Create the decision record file:

1. If `project/decision-records/` directory structure doesn't exist, create it
2. If filename conflicts, append numeric suffix (`-2`, `-3`)
3. Write the approved content
4. Update `project/decision-records/decision-records.index.md`:
   - Add entry to **Active Records** table
   - Format: `| [filename.md](filename.md) | Status | Y-Statement |`
   - Remove placeholder row if this is the first entry

**Success Criteria:**
- [ ] File created in correct location
- [ ] Filename follows naming convention
- [ ] Index file updated with new entry

---

### Step 8: Document

Confirm creation and provide next steps:

```
✓ Decision Record created: project/decision-records/{filename}
✓ Index updated: project/decision-records/decision-records.index.md

Next steps:
- Review and update status to 'Accepted' after approval
- Submit via Pull Request for team review
```

**Success Criteria:**
- [ ] User understands next steps
- [ ] Status lifecycle explained

---

## Adaptive Guidance

### For Different Decision Types

| Type | Focus Areas |
|------|-------------|
| **Technology Selection** | Fit with existing stack, team skills, vendor lock-in, support |
| **Architecture Patterns** | Scalability, maintainability, complexity trade-offs |
| **Process Changes** | Team adoption, tooling needs, transition plan |
| **Security Decisions** | Threat model, compliance requirements, audit trail |

### For Different Experience Levels

| Level | Approach |
|-------|----------|
| **Novice** | More context, explain patterns, connect to business outcomes |
| **Experienced** | Focus on trade-offs, challenge assumptions, explore edge cases |

---

## Error Handling

| Scenario | Action |
|----------|--------|
| User unsure of decision | Return to Step 1 (Discovery) |
| No alternatives provided | Ask: "What other options did you consider?" — require at least one |
| User says "none" to alternatives | Document as "No formal alternatives evaluated" with reason why |
| Unclear consequences | Ask "What happens if this goes wrong?" |
| Y-Statement unclear | Work through each clause individually |
| Filename conflict | Append numeric suffix (`-2`, `-3`) |
| No `project/decision-records/` directory | Create it |
