-- Deployed via Supabase migration create_cutsbymo_booking_requests_20261013.
-- This read-only source mirror defines only the Cuts by Mo tenant-specific table.
create table if not exists public.cutsbymo_booking_requests (
  id uuid primary key default gen_random_uuid(),
  reference text not null unique check (reference ~ '^CBM-[A-F0-9]{10}$'),
  created_at timestamptz not null default now(),
  requested_service text not null check (requested_service in ('Signature Cut','Skin Fade','Beard Grooming','Styling Session','Occasion Styling')),
  full_name text not null check (char_length(btrim(full_name)) between 2 and 100),
  phone text not null check (char_length(btrim(phone)) between 7 and 30),
  email text check (email is null or (char_length(email) <= 254 and email ~* '^[^[:space:]@]+@[^[:space:]@]+[.][^[:space:]@]+$')),
  preferred_date date not null,
  preferred_time text not null check (preferred_time ~ '^([01][0-9]|2[0-3]):[0-5][0-9]$'),
  timezone text not null default 'Asia/Dubai' check (timezone = 'Asia/Dubai'),
  service_location text not null check (char_length(btrim(service_location)) between 6 and 300),
  notes text not null default '' check (char_length(notes) <= 1000),
  consent boolean not null check (consent = true),
  status text not null default 'new' check (status in ('new','contacted','confirmed','completed','cancelled')),
  source text not null default 'cutsbymo.espacios.me' check (source = 'cutsbymo.espacios.me')
);
comment on table public.cutsbymo_booking_requests is 'Tenant-specific Cuts by Mo booking requests; no shared lead access.';
create index if not exists cutsbymo_bookings_status_date_idx on public.cutsbymo_booking_requests(status, preferred_date);
create index if not exists cutsbymo_bookings_created_idx on public.cutsbymo_booking_requests(created_at desc);
alter table public.cutsbymo_booking_requests enable row level security;
revoke all on table public.cutsbymo_booking_requests from public, anon, authenticated;
grant insert (reference, requested_service, full_name, phone, email, preferred_date, preferred_time, timezone, service_location, notes, consent, source) on public.cutsbymo_booking_requests to anon;
grant select, insert, update, delete on public.cutsbymo_booking_requests to service_role;
drop policy if exists cutsbymo_public_insert on public.cutsbymo_booking_requests;
create policy cutsbymo_public_insert on public.cutsbymo_booking_requests for insert to anon with check (status = 'new' and consent = true and source = 'cutsbymo.espacios.me');
