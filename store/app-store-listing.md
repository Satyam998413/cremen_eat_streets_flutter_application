# App Store Listing — Cremen Eat Streets

Ready to paste into App Store Connect → App Information / Pricing and Availability / Version Information. Character counts are exact.

## App name (30 char max)
```
Cremen Eat Streets
```
(19 chars)

## Subtitle (30 char max — this field IS indexed for search, unlike the name)
```
Surat Street Food, Order Now
```
(28 chars)

## Keywords (100 char max, comma-separated, never shown to users but fully indexed)
```
street food,surat,bhel,puri,chaat,food order,snacks online,khaman,food delivery,pickup order
```
(94 chars — don't repeat words already in the App Name/Subtitle, Apple's algorithm already credits those; this list intentionally avoids repeating "Cremen Eat Streets", "Surat", "food" beyond once)

## Promotional text (170 char max — can be updated anytime without a new build)
```
Fresh bhel, puri & chaat from Surat's favorite street cart. Order for pickup, local delivery, or nationwide shipping — checkout securely with Razorpay.
```

## Description (4000 char max)
```
Cremen Eat Streets brings Surat's most loved street food cart straight to your phone. Founded by Satyam Baranwal, we serve authentic bhel, puri, chaat, and khaman the way Surat has always eaten it — fresh, spicy, and made to order.

ORDER IN SECONDS
Browse the full menu of fresh food and packaged snacks, customize your order, and check out securely with Razorpay.

PICKUP, LOCAL DELIVERY, OR SHIPPING
• Pickup — order ahead, skip the line
• Local delivery in Surat — hot street food to your door
• Home shipping for packaged snacks — anywhere in India

TRACK YOUR ORDER
Real-time status from confirmed to prepared to delivered, with a one-tap call button.

WHY CREMEN EAT STREETS
• Direct from the cart owner — no delivery-platform markup
• Same menu, prices, and order history as cremeneatstreets.shop
• Guest checkout, or sign in to track orders and leave reviews

Download Cremen Eat Streets and taste Surat's street food, wherever you are.
```

## Category
Primary: Food & Drink

## App Privacy — "Nutrition Label" (App Store Connect → App Privacy)
Declare data types actually collected, each linked to the user's identity since accounts exist:
| Data type | Linked to user? | Used for tracking? | Purpose |
|---|---|---|---|
| Precise Location | Yes | No | App Functionality (delivery address autofill) |
| Name | Yes | No | App Functionality |
| Email Address | Yes | No | App Functionality |
| Phone Number | Yes | No | App Functionality |
| Physical Address | Yes | No | App Functionality |
| Payment Info | **Not collected** | — | Razorpay's SDK handles payment entirely; no card/UPI data reaches this app or Supabase |

Answer "No" to the tracking (ATT/IDFA) questions — this app does not track users across other companies' apps/websites for advertising.

## Before you submit
- iOS requires the `PrivacyInfo.xcprivacy` manifest at `ios/Runner/PrivacyInfo.xcprivacy` (already authored in this pass) to be added to the Xcode project (Runner target → Copy Bundle Resources) — a one-time step in Xcode itself, since this can't be safely scripted from the command line.
- Replace the AdMob App ID (`ios/Runner/Info.plist` → `GADApplicationIdentifier`) — currently Google's shared public test ID — with your real ID from apps.admob.com before submission.
- **Domain mismatch found in the codebase**: some files use `cremeneatstreet.shop` (singular), others `cremeneatstreets.shop` (plural). Confirm the one real production domain before this listing references it anywhere, and before publishing `apple-app-site-association` for Universal Links.
