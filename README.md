# Cuts by Mo

Private at-home grooming experience. Canonical site: https://cutsbymo.espacios.me

## Stack
- Frontend: accessible, responsive editorial liquid-glass HTML/CSS/JavaScript rendered from a standalone Cloudflare Worker.
- Typography: Espacios site font stack (`-apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif`).
- Booking API: Cloudflare Worker `POST /api/bookings`.
- Booking storage: Supabase `entity` project table `public.cutsbymo_booking_requests`, isolated with INSERT-only anonymous RLS access.
- Media: private Cloudflare R2 bucket `cutsbymo-media` with `MEDIA` Worker binding; photographs served through same-origin `/media/mo-standing-v1.jpg` and `/media/mo-seated-v1.jpg`.
- Contact: WhatsApp +971 52 455 9407, Fresha https://www.fresha.com/p/mo-4215109?share=true&pId=441033, and Instagram https://www.instagram.com/moamen.ebrahim_/ .
- Domain: dedicated Worker custom domain `cutsbymo.espacios.me` (no Espacios public-shell or PSR cross-tenant routing).

## Business rules
Booking requests are **not confirmed appointments**. Date/time choices are preferences, not real-time availability. No payment, automated email, WhatsApp, or instant confirmation is implied. The Mo portraits are supplied by the business; some haircut and lifestyle images are illustrative. The currently delivered site images are optimized preview-sized copies; use the full-resolution originals for the final media-quality pass. Service hours, coverage and pricing need owner validation.

## Deploy
`src/worker.js` is self-contained, with HTML/CSS/client JS embedded and `POST /api/bookings` logic.

Deploy via Wrangler with `wrangler deploy`, preserving the `MEDIA` R2 binding from `wrangler.jsonc`, and bind `SUPABASE_PUBLISHABLE_KEY` as a secret in the dedicated Worker. Do not commit the key or any customer submissions. `SUPABASE_URL` is non-secret.

Cloudflare Worker name: `cutsbymo-site`; repository: `gugmaae-prog/cutsbymo`.

## API security
Only same-origin JSON booking POSTs are accepted. Validation, an invisible honeypot, payload limits and Supabase database constraints apply. Public anonymous database role has insert access to approved columns only, with no read/update/delete. A production anti-bot/rate-limit layer (e.g. Turnstile) should be enabled before broader promotion.

## Notes
Mobile-first, reduced-motion friendly, theme toggle, booking wizard, keyboard accessible, no third-party JS trackers. Do not merge this business's customers with other Espacios businesses.

## Booking links and home service

The website prioritises *home-service* barbering in Dubai, while leaving service area and time approval to Mo. WhatsApp and Fresha links are external actions, not proof of booking, and they do not bypass the original Supabase booking-request workflow. The site preserves its four-step request modal, RLS-secured Supabase persistence, and health check.
