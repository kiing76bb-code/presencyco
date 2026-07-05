# Track B — Make.com Scenario Runbooks

Project: **mhtqvuglujodpffpmmhe** · Org **7601650** · Team **2271692**

All secrets via **Team Variables** — never hardcode in blueprints.

| Variable | Purpose |
|---|---|
| `presency_supabase_url` | `https://mhtqvuglujodpffpmmhe.supabase.co` |
| `presency_supabase_service_key` | Service role key (Make + server only) |
| `presency_anthropic_api_key` | Claude review drafts |
| `presency_telegram_bot_token` | Approval notifications |
| `presency_telegram_chat_id` | Bland/Jewell approval channel |

---

## Task 1 — Review Response Engine

**Trigger:** Webhook (Google review notification) or scheduled poll of GBP API  
**Flow:**

1. **Webhook** — receive `{ client_id, review_id, rating, review_text, business_name }`
2. **HTTP → Claude API** — draft warm on-brand reply referencing review content
3. **HTTP → Supabase REST** — `POST /rest/v1/review_responses`
   ```json
   {
     "client_id": "{{client_uuid}}",
     "review_id": "{{review_id}}",
     "rating": 5,
     "review_text": "...",
     "draft": "{{claude_output}}",
     "status": "pending"
   }
   ```
4. **Telegram** — send draft with one-tap approve instructions
5. **Do NOT auto-post to Google at launch** — approval required

**Claude system prompt (store in Make):**
> You write Google review responses for Las Vegas small businesses. Warm, specific, never generic. Reference something from the review. 2–3 sentences. Sign with the business name only — no "Powered by Presency."

---

## Task 2 — Booking Link in Text-Back

**Scenario:** Existing missed-call text-back (extend, don't rebuild)

**On onboarding webhook (5332510):** Map `booking_url` from intake → Supabase `clients.booking_url`

**Text-back SMS template:**
```
Hi {{caller_first_name}}, sorry we missed your call at {{business_name}}!
{{#if booking_url}}
Book your appointment here: {{booking_url}}
{{else}}
Give us a call back at {{business_phone}} — we're here to help.
{{/if}}
— {{business_name}}
```

**Make mapping:** After Supabase insert/update client, pass `booking_url` to Twilio module variable.

**Cal.com setup (free tier):** Jewell creates per client during onboarding when `booking_setup=need_cal`.

---

## Task 3 — Onboarding Webhook Field Map

Webhook: `https://hook.us2.make.com/o15lji6hwctniss6rmeikiek7e5mpmbc`

| Form field | Supabase column |
|---|---|
| `business_name` | `business_name` |
| `business_phone` | `phone` |
| `business_email` | `email` |
| `business_address` | parse → `city` (default Las Vegas) |
| `business_type` | `industry` |
| `booking_url` | `booking_url` |
| `selected_plan` | store in metadata or separate column |

Use **ILIKE** on `business_name` for client lookup — never UUID literals in Make filters.

---

## Task 4 — Telegram Approval (Review Responses)

When draft saved as `pending`:

```
📝 New review response — {{business_name}}
⭐ {{rating}}/5
"{{review_text}}"

Draft:
{{draft}}

Reply APPROVE {{review_id}} to post
Reply EDIT {{review_id}} | your text
```

Second scenario listens for Telegram replies → updates status → posts to GBP (manual phase).

---

## Verification Checklist

- [ ] `clients.booking_url` populated from onboarding test submit
- [ ] Test missed call fires SMS with booking link
- [ ] Test review creates row in `review_responses` with status `pending`
- [ ] Telegram notification received
- [ ] No hardcoded keys in any scenario blueprint
