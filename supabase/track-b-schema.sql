-- Presency Track B schema additions
-- Run in Supabase SQL Editor (project mhtqvuglujodpffpmmhe)

-- Booking link for missed-call text-back (Task 2)
alter table clients add column if not exists booking_url text;

-- Review response approval queue (Task 1)
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

create index if not exists review_responses_client_id_idx on review_responses(client_id);
create index if not exists review_responses_status_idx on review_responses(status);

alter table review_responses enable row level security;
