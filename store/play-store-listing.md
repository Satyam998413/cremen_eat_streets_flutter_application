# Play Store Listing — Cremen Eat Streets

Ready to paste into Play Console → Grow → Store presence → Main store listing. Character counts are exact; do not exceed them or Play Console will truncate/reject.

## App name (30 char max)
```
Cremen Eat Streets
```
(19 chars — keep the brand name as-is; don't keyword-stuff the title, Play's review guidelines flag that.)

## Short description (80 char max)
```
Order authentic Surat street food — bhel, puri, chaat — pickup or delivery.
```
(76 chars)

## Full description (4000 char max — keywords appear naturally throughout, Play indexes the whole thing)
```
Cremen Eat Streets brings Surat's most loved street food cart straight to your phone. Founded by Satyam Baranwal, we serve authentic bhel, puri, chaat, and khaman the way Surat has always eaten it — fresh, spicy, and made to order.

ORDER IN SECONDS
Browse our full menu of fresh food and packaged snacks, customize your order, and check out securely with Razorpay (UPI, cards, netbanking, wallets).

PICKUP OR DELIVERY
• Pickup — order ahead, skip the line, collect fresh from the cart
• Local delivery in Surat — hot street food delivered to your door
• Home shipping for packaged snacks — enjoy Cremen Eat Streets anywhere in India

TRACK YOUR ORDER
Real-time order status from confirmed to prepared to delivered, plus a direct call button if you ever need to reach us.

WHY CREMEN EAT STREETS
• Direct from the cart owner — no delivery-platform markup
• The same menu, prices, and order history whether you order on the app or on cremeneatstreets.shop
• Simple guest checkout, or sign in to track your order history and leave reviews

Download Cremen Eat Streets and taste Surat's street food, wherever you are.
```

## Category
Food & Drink

## Tags / keywords to weave into future updates
street food, Surat, bhel, puri, chaat, khaman, food order, snacks online, food delivery, pickup order

## Contact details
- Email: (use the same support email as cremeneatstreets.shop)
- Phone: 8948998413
- Website: https://cremeneatstreets.shop *(confirm canonical domain first — see note below)*

## Data Safety form (Play Console → App content → Data safety)
Declare the following collection/sharing — matches what the app actually does, nothing more:
| Data type | Collected? | Shared? | Purpose |
|---|---|---|---|
| Approximate/precise location | Yes | No | App functionality (autofill delivery address at checkout) |
| Name, email address, phone number | Yes | No | App functionality (account, order fulfillment, order tracking) |
| Physical address | Yes | No | App functionality (delivery address) |
| Financial info (payment details) | **No** | — | Payment is handled entirely by Razorpay's own SDK — card/UPI details never reach this app's code or its Supabase database |

All data collection should be marked **encrypted in transit**, and **user can request deletion** (via account deletion / support contact) — confirm the actual account-deletion path exists before submitting; if it doesn't yet, add one, since Play requires it for any app with account creation.

## Before you submit
- **Domain mismatch found in the codebase**: some files use `cremeneatstreet.shop` (singular) and others `cremeneatstreets.shop` (plural) — confirm the one real production domain before publishing this listing or any deep-link verification file referencing it.
- Replace the AdMob App ID (currently Google's shared public *test* ID on both platforms) with your real ID from apps.admob.com before this build goes live — Play policy prohibits shipping test ad IDs in a production listing.
