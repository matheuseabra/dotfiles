---
name: html-it
description: Use when the user asks for an HTML artifact, rendered report, visual explainer, interactive document, throwaway browser tool, dashboard, HTML plan, or an exportable review and decision interface.
---

# HTML Artifacts

Create a self-contained HTML artifact when spatial layout, visual explanation,
interaction, or sharing makes it substantially more useful than Markdown.

Do not replace explicitly requested Markdown, source documentation, commit
messages, or small text answers. Do not create HTML merely for decoration.

## Choose The Smallest Useful Level

1. **Static document:** A readable report, plan, explainer, or summary with a
   clear hierarchy, concise overview, tables, callouts, and responsive layout.
2. **Visual artifact:** A static document enhanced with comparison grids, SVG
   diagrams, charts, annotated code, or before-and-after views.
3. **Interactive document:** A browser-only artifact with controls, live
   previews, or inline decisions. Include a clearly labelled export action.
4. **Throwaway tool:** A focused, single-purpose browser interface for work
   such as triage, curation, review, configuration, or prioritisation. Include
   validation and an export action when the user's choices should feed back
   into the next task.

Prefer Markdown for a short answer, a diffable durable document, or material
that must remain the repository's canonical source of truth.

## Build Rules

- Use one portable `.html` file with inline CSS and JavaScript unless the
  project has an established frontend implementation that should be extended.
- Follow the existing project's visual language. When none exists, use a
  restrained editorial layout rather than a generic dashboard.
- Make the artifact responsive, legible on a phone, keyboard-operable where
  interactive, and semantically structured with real headings, labels, and
  controls.
- Prefer SVG for diagrams and simple inline CSS/SVG charts over external
  libraries. Do not add a build step or dependencies for a throwaway artifact.
- Keep data local to the page. Do not add a backend, authentication, tracking,
  or deployment unless the user asks.
- Write the artifact to the user-requested location. Otherwise choose an
  appropriate untracked artifact or temporary location without overwriting
  existing work.

## Interactive Export Contract

For Level 3 or 4 artifacts, provide an explicit action such as `Copy as
Markdown`, `Copy as JSON`, or `Copy as prompt`. The export must accurately
represent the current state of the controls or decisions. Confirm completion
visibly and provide a fallback when clipboard access is unavailable.

## Verification

- Open or render the page with an available browser or preview tool when the
  user requests a preview or the artifact is visually important.
- Check that controls work, exports reflect page state, and the layout remains
  usable at a narrow viewport.
- Report the file path, selected level, verification performed, and any
  intentionally omitted capabilities.

## Attribution

Adapted for general agents from `robonuggets/html-it`, which applies Thariq
Shihipar's four-level HTML artifact framework:
https://github.com/robonuggets/html-it
