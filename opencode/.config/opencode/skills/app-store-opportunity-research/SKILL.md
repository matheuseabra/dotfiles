---
name: app-store-opportunity-research
description: Find profitable mobile app ideas through App Store charts, competitor gaps, revenue validation, top-3 reports, and MVP PRDs. Use when users ask to find app opportunities, do App Store research, decide what app to build, research an app category, or find an App Store market gap.
metadata:
  tags: app-store, research, mobile-app, competitor-analysis, market-research, prd, indie-hacker, startup
---

# App Store Opportunity Research

Run a research pipeline for underserved App Store opportunities:

```
App Store charts -> competitor deep-dive -> gap analysis -> top-3 report -> selected MVP PRD
```

Use live browser or web-research tools for all market claims. Do not invent App Store ratings, pricing, review themes, revenue, or competitor capabilities. Cite source URLs in the report and label estimates as estimates.

## When To Use

Use this skill when the user wants to:

- Find profitable app ideas in a category or niche.
- Research App Store charts for underserved opportunities.
- Analyze competitor ratings, reviews, revenue, or feature gaps.
- Generate a revenue-validated top-3 opportunity report.
- Write an MVP PRD after choosing an opportunity.

## Scope Questions

Before research, ask these questions if the user has not already supplied the answers:

1. What category or problem space should be explored?
2. Consumer or B2B?
3. What are the budget constraints, particularly for AI/API costs?
4. What revenue goal matters: hobby income or a larger business?

Help narrow overly broad categories. Prefer a user, problem, or technology intersection such as "sleep and anxiety for consumers", "habit tracking for fitness beginners", or "AI-powered journaling".

## Research Workflow

### 1. Charts

Browse the relevant iPhone category chart, for example:

- Health & Fitness: `https://apps.apple.com/us/charts/iphone/health-fitness-apps/6013`
- Lifestyle: `https://apps.apple.com/us/charts/iphone/lifestyle-apps/6012`
- Productivity: `https://apps.apple.com/us/charts/iphone/productivity-apps/6007`
- Education: `https://apps.apple.com/us/charts/iphone/education-apps/6017`
- Medical: `https://apps.apple.com/us/charts/iphone/medical-apps/6020`
- Entertainment: `https://apps.apple.com/us/charts/iphone/entertainment-apps/6016`

Document the top 25-50 relevant apps: rank, name, rating count, star rating, price or monetization, short positioning, and listing URL. Treat rating count only as an imperfect proxy for adoption.

Look for these patterns:

- More than 100K ratings often signals a saturated incumbent, not an automatic rejection.
- 1K-50K ratings can demonstrate proven, beatable demand.
- Under 500 ratings may identify a new or underserved segment, but can also mean weak demand.

### 2. Competitor Deep-Dive

For 3-5 promising niche areas, research 5-8 direct competitors each. Record:

| Field | Evidence source |
|---|---|
| Name, ratings, stars, pricing | App Store listing |
| Features and positioning | Listing, site, screenshots |
| Complaints | Recent low-star App Store reviews and independent reviews |
| Trust signals | Trustpilot or other credible review source, when available |
| Revenue | Credible direct source, disclosed metrics, or clearly labeled estimate |
| Missing features | Cross-competitor comparison and recurring complaints |

Search for direct revenue evidence first. If unavailable, show assumptions behind any estimate; a rough install proxy is `rating_count * 40-80`, and common paid conversion benchmarks are 2-5% of free users. Do not present proxy calculations as reported revenue.

Avoid or substantially discount niches dominated by million-rating incumbents, hardware dependencies, heavy medical or financial regulation, or entirely free markets without a credible monetization path. Favor recurring complaints across multiple competitors, poor competitor satisfaction, clear willingness to pay of $5-15/month, and evidence that small teams can compete.

### 3. Gap Analysis

Create a feature comparison matrix for each viable niche:

| Feature | Competitor A | Competitor B | Competitor C | Proposed app |
|---|---|---|---|---|
| Core feature | Yes | Yes | No | Yes |
| Differentiating feature | No | No | No | Yes |
| Price | $9.99/mo | $6.99/mo | Free | $5.99/mo |
| UX quality | Poor | Good | OK | Premium |

A strong opportunity has proven demand, a shared feature gap, user evidence for that gap, and sufficient pricing power for an indie business.

### 4. Opportunity Report

Produce the following and stop for the user's selection before writing any PRD:

```markdown
# Top 3 App Opportunities in {Category}

## Opportunity 1: {App Name} (RECOMMENDED)
**One-line pitch:** {10 words or fewer}
**The gap:** {Missing market capability}
**Target user:** {Who and why they would pay}
**Revenue model:** {Price and conversion assumptions}
**Revenue path:** {Path to target monthly revenue, with math}
**Competition:** {Relevant competitors and advantage}
**Build complexity:** Low / Medium / High
**Confidence:** High / Medium / Low, with evidence and uncertainty
**Sources:** {URLs}

## Opportunity 2: {App Name}
...

## Opportunity 3: {App Name}
...

## Recommendation
{Why opportunity one is the best bet}
```

State which numbers are reported versus estimated. Favor conservative revenue assumptions and call out validation experiments needed before building.

## MVP PRD

Only after the user chooses an opportunity, write a full PRD and save it in the active project as `PRD-{AppName}.md`. Use ASCII filenames; replace spaces with hyphens.

Include these sections:

1. Executive Summary
2. Market Opportunity
3. Target Users: three personas
4. MVP Feature Set: 5-8 detailed feature groups, behavior, and edge cases
5. Screen Map: parent/child screens
6. User Flow: onboarding through daily use
7. Monetization: free/premium split, price, trial
8. Tech Stack: framework, libraries, state, persistence
9. AI Features: scope and explicit exclusions, if applicable
10. Data Models: TypeScript interfaces for core entities
11. Design Direction: hex palette, typography, components, mood
12. Launch Strategy: weeks 1-12
13. Success Metrics: measurable KPI targets
14. Risks & Mitigations: five material risks
15. Compliance: privacy, data handling, App Store requirements
16. Future Roadmap: V2 and V3

## Commercial Benchmarks

Use these as broad sanity checks, not proof of a market:

| App type | Solo developer benchmark |
|---|---|
| Niche utility | $1K-$5K/mo |
| Habit/tracker | $5K-$15K/mo |
| Gamified self-care | $10K-$50K/mo |
| Meditation/wellness | $5K-$20K/mo |
| Productivity | $3K-$10K/mo |
| AI-powered tool | $5K-$30K/mo |

Typical price ranges: $2.99-$4.99/month for simple utilities, $5.99-$6.99/month for most indie apps, and $9.99-$14.99/month for AI-heavy or professional products. Validate price sensitivity with current competitors and user research.

For launch planning, match channels to the product: TikTok or Instagram Reels for visual consumer apps, Reddit for niche communities, Product Hunt for productivity and developer tools, and Apple Search Ads for testable acquisition. Include expected cost and time-to-signal where evidence exists.
