# Presency — Master Map v2 Workspace

**Axis Creative LLC · Las Vegas · July 5, 2026**

Canonical repo for Presency product, site, and Track B upgrades.  
Live domain: [presencyco.com](https://presencyco.com)

## Architecture (v2)

| Service | Price | Status |
|---|---|---|
| 24/7 Revenue Recovery | $297/mo | Upgrade (booking link in text-back) |
| Google Business Domination | $297/mo | Upgrade (absorbs GBP posts from social) |
| Reputation Management | $297/mo | Upgrade (AI review responses) |
| AI Chat Widget | $347/mo | Keep |
| AI Search Visibility | $197/mo add-on | **New** |
| ~~Social Media Auto-Poster~~ | retired | Remove from site + Stripe |

### Packages (staged — confirm before Stripe push)

| Package | Contents | Price |
|---|---|---|
| Starter | Revenue Recovery + GBP Domination | $497/mo |
| Presence | Starter + Reputation + Chat Widget | $897/mo |
| Full Front Office | Presence + AI Search Visibility | $1,397/mo |
| Build Your Own | À la carte, 3+ discount | from $297/mo |

Setup fee: $400 one-time (all packages)

## Two-Track Plan

**Track A (BLOCKER — must pass before Track B ships)**  
Telnyx A2P 10DLC · credential rotation · Make scenario 5332510 bulletproofing · EMAIL-FIRST launch

**Track B (this repo — queued after Track A gate)**  
1. Review response engine (Claude → Supabase → Telegram approval)  
2. Booking link in missed-call text-back (Cal.com free tier)  
3. Site updates (retire social, add AI Visibility, ROI calculator)  
4. Stripe restructure (archive social poster, add AI Visibility price)  
5. SEO baseline (sitemap, robots, Search Console, JSON-LD)

## Stack

- **Site:** Static HTML on GitHub Pages + Cloudflare DNS
- **DB/Auth:** Supabase `mhtqvuglujodpffpmmhe`
- **Automation:** Make.com org `7601650` / team `2271692`
- **Payments:** Stripe (Axis Creative LLC)
- **Comms:** Twilio + Telnyx (A2P pending)

## Brand

Presency Gold `#C9A84C` · Black `#080808` · Surface `#0E0E0E`

## Repo layout

```
index.html          Marketing homepage
onboarding.html     Client intake form → Make webhook
dashboard.html      Client PWA (Supabase-backed)
privacy.html        Privacy policy
terms.html          Terms of service
docs/               Runbooks, checklists, audit (add as we go)
```

## Known issues (July 5 audit)

See `docs/AUDIT.md` for full system audit.
