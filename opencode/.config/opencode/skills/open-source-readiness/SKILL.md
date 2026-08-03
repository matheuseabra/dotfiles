---
name: open-source-readiness
description: Use when preparing a repository for open source, a public release, a GitHub release, release readiness, or improving a project's baseline quality. Audits and implements low-friction installation, automated quality gates and tag-based releases, and problem-first documentation.
---

# Open-Source Readiness

Turn a working repository into something a new user and contributor can trust.

Use this skill for an existing project that needs release or open-source hardening. Do not apply it to a private prototype unless the user asks for public-release or baseline-quality work.

## Outcome

Improve the three user-facing foundations, in this order:

1. **Installation surface:** a newcomer can install or run the project with the lowest practical friction.
2. **Confidence and releases:** automated checks establish a shared quality baseline; releases are predictable and tag-driven.
3. **Documentation:** the README explains the problem and a quick start; deeper contributor and architectural material lives in `docs/`.

The goal is not a maximal enterprise compliance program. Make the smallest changes that materially improve the project for a stranger.

## Operating Rules

- Inspect local `AGENTS.md`, project scripts, existing workflows, packaging metadata, documentation, and CI before proposing changes.
- Identify project type and distribution model first: library, CLI, web app, desktop/mobile app, service, container image, or monorepo. Match the implementation to it.
- Preserve established commands and conventions where they work. Prefer wiring existing checks over introducing a new toolchain.
- Never publish packages, push tags, create releases, deploy, upload artifacts, or change repository settings unless the user explicitly requests that action.
- Do not manufacture release credentials, signing configuration, registry tokens, or platform-specific package integrations. Add secure templates or documentation only when useful.
- Do not claim installation, tests, CI, release workflows, or documentation are verified unless you actually ran the relevant local checks or inspected the relevant artifact.
- Keep real secrets out of the repository. Version only a sanitized `.example` file and ensure the real local file is ignored.

## Phase 1: Baseline Audit

Before editing, inspect:

- root files: `README*`, `LICENSE*`, `CHANGELOG*`, contribution and security guidance, package/build metadata, `.gitignore`;
- scripts and local development commands;
- tests, linters, formatters, type checks, security/dependency scans already in use;
- `.github/workflows/` or the current CI provider;
- current release/versioning and artifact-distribution approach;
- `docs/` and whether the README starts with the user problem or implementation details.

Report or track a concise gap list grouped by the three foundations. Do not call a missing packaging channel a defect when the project type does not need it. For example, a hosted web app might need a clear local run command and deployed demo rather than downloadable binaries.

## Phase 2: Installation Surface

Make the happy path obvious, copy-pasteable, and realistic.

### Required standard

- Put the preferred install or run command near the top of the README.
- State platform, runtime, toolchain, and external-service prerequisites honestly.
- Provide at least one path that does not require a contributor to understand the source tree.
- Verify the documented quick-start path locally when feasible.

### Match the project

| Project type | Prefer |
| --- | --- |
| CLI or desktop binary | release artifact for supported platforms, plus a package-manager path only where maintained |
| Library | the ecosystem-native install command and a minimal usage example |
| Web app or service | clone/run or container path, environment example, and a production/demo URL when available |
| Containerized service | a small `docker compose` or documented `docker run` path with persistent configuration explained |
| Monorepo | one root bootstrap command plus focused package commands |

For compiled CLIs, favor building each binary once per target and reusing that exact artifact for archives, checksums, images, and package-manager wrappers. Do not add every package ecosystem speculatively. Start with a portable artifact and the channels the project can sustain.

## Phase 3: Confidence and Releases

### Quality gates

Create or improve CI so every pull request and protected-branch push runs the project-appropriate checks. Start with the checks already declared by the repository.

Typical gate order:

1. formatting;
2. lint/static analysis/type checking;
3. tests;
4. build or package validation;
5. dependency or security audit when the ecosystem has a practical, maintained tool.

Keep CI fast and deterministic. Cache dependencies or build outputs only when it meaningfully reduces repeated work without weakening correctness. Run cross-platform tests on native executors when possible; do not claim a cross-compiled binary was tested on an incompatible architecture.

### Tag-driven release workflow

Separate PR CI from releases. A release should normally trigger only from version tags matching the project convention, for example `v*.*.*`, and may also support explicit manual dispatch for maintainers.

The workflow should:

1. validate version/tag consistency where a version file exists;
2. build the release artifacts once per supported target;
3. generate checksums for downloadable artifacts;
4. create a GitHub Release using release notes derived from the changelog;
5. publish to configured distribution channels only when credentials and an existing channel justify it.

Keep release jobs idempotent when safe to do so. A retry must not accidentally duplicate external releases or corrupt metadata.

### Changelog

Use `CHANGELOG.md` in Keep a Changelog style unless the repository has an established alternative. Each released version needs a dated section, and an `Unreleased` section is preferred.

Release notes must explain what changed. Extract the matching version section automatically when practical; append install information and artifact checksums for binary releases. Do not generate an empty or generic changelog merely to satisfy a checklist.

## Phase 4: Documentation

### README standard

Lead with a one-sentence problem statement and intended audience, not the technology stack. A first-time visitor should be able to answer:

- What does this solve?
- Who is it for?
- How do I install or run it now?
- What is the smallest useful example?
- Where do I find contributing, security, licensing, and detailed docs?

Keep the README short enough to scan. Move architecture, design decisions, internals, operational runbooks, and extended examples into `docs/` with clear links.

### Contribution baseline

Add only what is appropriate and can be maintained:

- `CONTRIBUTING.md` with local setup, test/lint commands, and PR expectations;
- a license selected or confirmed by the maintainer; do not choose a license without their authorization;
- `SECURITY.md` with a private reporting channel if the project handles user data, credentials, network exposure, or supply-chain-sensitive behavior;
- issue and PR templates only when the repository is actively accepting contributions.

## Implementation Sequence

1. Audit the repo and state the intended release boundary.
2. Fix the installation/readme happy path first.
3. Wire existing quality commands into CI; add missing high-value checks only when justified.
4. Add or repair changelog and tag-driven release automation.
5. Add focused contributor and deeper docs.
6. Run the strongest relevant local verification: documented quick start, format/lint/typecheck/test/build, and workflow syntax or a local equivalent.
7. Summarize changed files, commands run, results, remaining manual requirements, and intentionally deferred distribution channels.

## Completion Criteria

The project is ready for a first public release when:

- a stranger can follow a documented, verified install/run path;
- automated checks cover the project’s meaningful correctness and quality commands on PRs;
- release creation is deterministic from a version tag and release notes communicate the version’s changes;
- the README leads with the problem and quick start, with deeper documentation linked;
- no secrets, hostnames, personal paths, or production credentials are tracked.

## Source Principle

Adapted from Fabio Akita, "Open Source Best Practices with LLMs - The Bare Minimum" (May 30, 2026): https://akitaonrails.com/en/2026/05/30/open-source-best-practices-llm-the-minimum/
