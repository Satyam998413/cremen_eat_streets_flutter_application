# Store Asset Checklist — Cremen Eat Streets

Exact required dimensions so screenshots/graphics can be produced against a concrete spec, rather than guessed at submission time.

## App icon (already generated — see pubspec.yaml `flutter_launcher_icons:`)
- Source: `assets/images/cremen_logo.jpg` (1024×1024) — legacy/iOS/Windows icon.
- Adaptive foreground: `assets/images/cremen_logo_adaptive_fg.png` (1024×1024, logo scaled to 66% + transparent margin) — Android 8+ adaptive icon.
- iOS App Store marketing icon: `ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png` — already present, no further action.

## Google Play Store
| Asset | Size | Format | Required? |
|---|---|---|---|
| App icon (hi-res) | 512×512 | 32-bit PNG, no alpha | Required |
| Feature graphic | 1024×500 | JPG or 24-bit PNG, no alpha | Required |
| Phone screenshots | min 320px, max 3840px per side, 16:9 or 9:16 | JPG/PNG | 2–8 required |
| 7" tablet screenshots | same constraints as phone | JPG/PNG | Optional but recommended |
| 10" tablet screenshots | same constraints as phone | JPG/PNG | Optional but recommended |
| Promo video | YouTube URL | — | Optional |

Recommended screenshot set (5–6 covering the golden path): Home/catalog grid, product detail with reviews, cart, checkout (Razorpay sheet or fulfillment picker), order tracking stepper.

## Apple App Store
| Asset | Size | Format | Required? |
|---|---|---|---|
| App icon | 1024×1024 | PNG, no alpha, no rounded corners (Apple applies the mask) | Required — already have it |
| iPhone 6.7" screenshots (iPhone 15/16 Pro Max class) | 1290×2796 px | PNG/JPG | Required (up to 10) |
| iPhone 6.5" screenshots (iPhone 11 Pro Max/XS Max class) | 1242×2688 px | PNG/JPG | Required if supporting that size class |
| iPad Pro 12.9" screenshots | 2048×2732 px | PNG/JPG | Required only if the app supports iPad |
| App preview video | Same resolutions as screenshots, 15–30s, .mov/.mp4 | Optional |

Same recommended screenshot set as Play: Home, product detail, cart, checkout, order tracking — captured on an iPhone 15/16 Pro Max simulator or device for the 6.7" set.

## Notes
- Screenshots should be captured after the UI/animation modernization pass in this repo is complete, so they reflect the current app, not the pre-polish screens.
- Neither store accepts screenshots with visible status-bar clock/battery mismatches across the set — use a consistent simulator time (e.g. 9:41) or a real device with airplane mode.
