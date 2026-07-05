# Presency System Audit — July 5, 2026

## Critical: split deployment

| URL | Live state | Local repo state |
|---|---|---|
| presencyco.com/ | **Waitlist "Opening Soon"** page | Full marketing site with pricing |
| presencyco.com/onboarding.html | Full intake form ($497/$897, social poster) | Same + minor uncommitted edits |
| presencyco.com/index.html | Does NOT match git `main` | Repriced tiers, no waitlist |

**Impact:** Prospects hitting the homepage see a waitlist; direct links to onboarding see the real product. Sales story and SEO are broken at the front door.

**Fix:** Deploy local `index.html` (or v2 homepage with ROI calculator) and retire the waitlist page immediately after Track A gate — or now if Bland wants leads flowing.

---

## What works

| Area | Evidence | Notes |
|---|---|---|
| Brand & design | Gold/black luxury system consistent across HTML files | Strong, differentiated for Vegas SMB market |
| Pricing architecture (v2 map) | Research-backed repositioning | Loss math, AI visibility angle, package value up without price hike |
| Onboarding form | Live at /onboarding.html, posts to Make webhook | Conditional sections, plan logic, BYO builder |
| Make contact flow | Scenario 5295075 active → hello@presencyco.com | Lead capture works |
| Google Workspace | hello@presencyco.com live | MX on Cloudflare |
| Supabase project | mhtqvuglujodpffpmmhe provisioned | Dashboard scaffold exists |
| Stripe account | Live, payment links existed (need reprice/rebuild) | Immutable prices — archive + create new |
| Legal pages | privacy.html, terms.html in repo | Ready to deploy |
| Sales ammunition (v2) | Loss math, Vegas angle, FFO AI closer | Ves-ready copy in master map |
| Two-track sequencing | Track A compliance before Track B product | Correct risk ordering |

---

## What doesn't work / is stale

| Area | Problem | Severity |
|---|---|---|
| Homepage deployment | Waitlist page live; full site never pushed or was overwritten | **P0** |
| SEO | No sitemap.xml, no useful robots.txt, zero indexing | **P0** |
| Service naming (site) | Still "Missed Call Text-Back", not "24/7 Revenue Recovery" | P1 |
| Social Auto-Poster | Still in index, onboarding, FFO tier — v2 retires it | P1 |
| AI Search Visibility | Not on site, not in Stripe, no deliverables checklist | P1 |
| Stripe payment links | CTAs route to #contact; links still at old $397/$697/$1197 | P1 |
| Onboarding scenario 5332510 | Inactive; hardcoded Supabase + Twilio creds in blueprint | **P0** |
| Telnyx A2P 10DLC | Not registered; window ~July 10 | **P0** |
| Credential hygiene | Twilio token + Supabase JWT need rotation into Team Variables | **P0** |
| Repo sprawl | presencyco, Presency, Desktop/presency-platform, Downloads copies, native app | P1 |
| Context docs | Brain_Trust presency-context.md has June pricing, old 5-service list | P2 |
| Dashboard | Hardcoded anon key (expected) but no review_responses table yet | P2 |
| Next.js platform | Downloads/presency-platform scaffolded, never deployed, stale Stripe prices | P2 (parallel dead end) |
| business_name source | Undefined — Stripe doesn't collect it | P1 |
| Competitor SERP | Another entity owns "Presency" search results | P1 |

---

## Bug ledger (from Master Handoff v1)

6 fixed, 9 open. Track A closes the critical opens (scenario creds, A2P, VALUE field rebinds, idempotency, alerting).

---

## Master Map v2 — document quality

**Strengths:** Clear verdict per service, staged Stripe changes, copy-paste Claude brief, owner assignments, Vegas sales angle.

**Gaps:**
- No deployment state truth table (now added above)
- No acceptance criteria per Track B task
- No Jewell/Ves operational runbooks (only architecture)
- Pricing decision ($247 vs $297 reputation) still open on Bland
- References "Clark (Code)" tasks with hour estimates but no test plan
