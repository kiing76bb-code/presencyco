-- Presency full schema (base + Track B)
-- Project: mhtqvuglujodpffpmmhe
-- Safe to re-run: uses IF NOT EXISTS / IF NOT EXISTS column adds

-- ── clients ──────────────────────────────────────────────────────────────────
create table if not exists clients (
  id                      uuid primary key default gen_random_uuid(),
  created_at              timestamptz not null default now(),
  business_name           text not null,
  owner_name              text not null,
  email                   text not null unique,
  phone                   text not null,
  city                    text not null,
  industry                text not null,
  stripe_customer_id      text,
  stripe_subscription_id  text,
  subscription_status     text not null default 'pending'
    check (subscription_status in ('pending', 'active', 'paused', 'cancelled')),
  booking_url             text
);

alter table clients add column if not exists booking_url text;

-- ── client_services ───────────────────────────────────────────────────────────
create table if not exists client_services (
  id                    uuid primary key default gen_random_uuid(),
  client_id             uuid not null references clients(id) on delete cascade,
  service_type          text not null
    check (service_type in (
      'missed_call', 'review_automation', 'social_poster',
      'chat_widget', 'google_biz', 'ai_visibility'
    )),
  status                text not null default 'provisioning'
    check (status in ('provisioning', 'active', 'error', 'pending_manual')),
  twilio_number         text,
  make_scenario_id      text,
  voiceflow_agent_id    text,
  voiceflow_embed_code  text,
  buffer_channel_id     text,
  google_sheet_url      text,
  activated_at          timestamptz
);

-- ── review_responses (Track B) ────────────────────────────────────────────────
create table if not exists review_responses (
  id            uuid primary key default gen_random_uuid(),
  created_at    timestamptz not null default now(),
  client_id     uuid references clients(id) on delete cascade,
  review_id     text not null,
  rating        smallint check (rating between 1 and 5),
  review_text   text,
  draft         text not null,
  status        text not null default 'pending'
    check (status in ('pending', 'approved', 'posted', 'rejected')),
  posted_at     timestamptz,
  unique (review_id)
);

-- ── indexes ───────────────────────────────────────────────────────────────────
create index if not exists clients_email_idx on clients(email);
create index if not exists clients_stripe_customer_idx on clients(stripe_customer_id);
create index if not exists client_services_client_id_idx on client_services(client_id);
create index if not exists client_services_status_idx on client_services(status);
create index if not exists review_responses_client_id_idx on review_responses(client_id);
create index if not exists review_responses_status_idx on review_responses(status);

-- ── RLS ───────────────────────────────────────────────────────────────────────
alter table clients enable row level security;
alter table client_services enable row level security;
alter table review_responses enable row level security;

drop policy if exists "Clients can read own record" on clients;
create policy "Clients can read own record"
  on clients for select
  using (email = auth.jwt() ->> 'email');

drop policy if exists "Clients can read own services" on client_services;
create policy "Clients can read own services"
  on client_services for select
  using (
    client_id in (
      select id from clients where email = auth.jwt() ->> 'email'
    )
  );
