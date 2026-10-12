# Cuts by Mo

Private at-home grooming experience. Canonical site: https://cutsbymo.espacios.me

## Stack
- Frontend: accessible, responsive editorial liquid-glass HTML/CSS/JavaScript rendered from a standalone Cloudflare Worker.
- Typography: Espacios site font stack (`-apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif`).
- Booking API: Cloudflare Worker `POST /api/bookings`.
- Booking storage: Supabase `entity` project table `public.cutsbymo_booking_requests`, isolated with INSERT-only anonymous RLS access.
- Domain: dedicated Worker custom domain `cutsbymo.espacios.me` (no Espacios public-shell or PSR cross-tenant routing).

## Business rules
Booking requests are **not confirmed appointments**. Date/time choices are preferences, not real-time availability. No payment, automated email, WhatsApp, or instant confirmation is implied. Photos are illustrative; replace them with Mo's approved portfolio. Service hours, coverage and pricing need owner validation.

## Deploy
`src/worker.js` is self-contained, with HTML/CSS/client JS embedded and `POST /api/bookings` logic.

Deploy via Wrangler with `wrangler deploy` and bind `SUPABASE_PUBLISHABLE_KEY` as a secret in the dedicated Worker. Do not commit the key or any customer submissions. `SUPABASE_URL` is non-secret.

Cloudflare Worker name: `cutsbymo-site`; repository: `gugmaae-prog/cutsbymo`.

## API security
Only same-origin JSON booking POSTs are accepted. Validation, an invisible honeypot, payload limits and Supabase database constraints apply. Public anonymous database role has insert access to approved columns only, with no read/update/delete. A production anti-bot/rate-limit layer (e.g. Turnstile) should be enabled before broader promotion.

## Notes
Mobile-first, reduced-motion friendly, theme toggle, booking wizard, keyboard accessible, no third-party JS trackers. Do not merge this business's customers with other Espacios businesses.
