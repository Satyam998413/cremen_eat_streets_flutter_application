# Play Store Listing & AI-Powered ASO Guide — CremenKart

Optimized for Google Play Store Ranking, Gemini Search Semantic Indexing, and Google App Indexing (Google Search AI Overviews).

---

## 1. Store Metadata (Exact Play Console Limits)

### App Name (30 characters max)
*Recommended (Best for keyword ranking & AI search):*
```
CremenKart: Street Food Order
```
*(29 chars — blends brand authority with top-searched keywords "Street Food" & "Order")*

*Alternative (Brand-only):*
```
CremenKart
```
*(10 chars — clean minimalism)*

---

### Package Name / Application ID
```
com.cremen.cremenkart
```

---

### Short Description (80 characters max)
```
Order authentic Surat street food, chaat & snacks for quick pickup & delivery.
```
*(78 chars — contains high-intent keywords: Surat, street food, chaat, snacks, pickup, delivery)*

---

### Full Description (4,000 characters max)
*(Engineered with semantic keyword density, natural language intent for AI search engines, and structured bullet points)*

```
Welcome to CremenKart — Surat’s favorite authentic street food and snacks cart, now in your pocket! 

Craving the unmistakable taste of authentic Surat street food? Founded by Satyam Baranwal, CremenKart brings you fresh, spicy, and hygienic street food prepared live, alongside a wide range of packaged snacks delivered straight to your doorstep.

🍽️ WHAT YOU CAN ORDER ON CREMENKART
• Authentic Chaat & Bhel: Crispy Sev Puri, spicy Bhel Puri, Dahi Puri, Papdi Chaat, and Pani Puri made with real, traditional Surati spices.
• Fresh Surati Farsan & Khaman: Melt-in-mouth nylon khaman, locho, and seasonal farsan.
• Packaged Snacks & Namkeen: Authentic Gujarati bhujia, sev, chivda, and wafers shipped nationwide across India.
• Cold Beverages & Refreshments: Perfect companions for your spicy street food feasts.

⚡ ORDER YOUR WAY: PICKUP OR DELIVERY
1. Skip the Queue (Pickup): Order ahead on your phone, walk up to the Cremen cart, and collect your fresh food piping hot with zero waiting time.
2. Local Surat Delivery: Fast and hot street food delivered to your home or office in Surat.
3. All-India Shipping: Get your favorite authentic packaged snacks and namkeen shipped anywhere across India.

💎 WHY FOODIES LOVE CREMENKART
• Direct from the Cart Owner: No inflated middleman prices or third-party delivery markups. Get genuine cart prices every time.
• 100% Hygienic & Fresh: Clean prep stations, pure ingredients, and hygienic packaging.
• Seamless UPI & Online Payments: Pay securely in seconds via Razorpay (Google Pay, PhonePe, Paytm, UPI, Cards, Netbanking).
• Real-time Order Tracking: Track your food from the kitchen counter to your doorstep, with direct contact to our team.
• Seamless Web & App Sync: One single account across the CremenKart app and our official website https://cremen.in.

📍 FREQUENTLY ASKED QUESTIONS (FAQ)
Q: Where is CremenKart located?
A: CremenKart operates out of Surat, Gujarat, delivering hot street food locally across Surat and shipping packaged snacks nationwide.

Q: How can I track my order?
A: You can track your order live inside the app under the Orders tab or via the instant tracking link sent with your order.

Q: What payment methods are supported?
A: We support all Indian UPI apps (PhonePe, GPay, Paytm), Debit/Credit cards, Netbanking, and digital wallets through Razorpay’s secure 256-bit encrypted gateway.

Download CremenKart today and experience Surat’s most celebrated street food, wherever you are!
```

---

## 2. Store Presence & Categorization
- **Primary Category**: Food & Drink
- **Store Tags**:
  - `Food delivery`
  - `Online food ordering`
  - `Fast food`
  - `Restaurant`
  - `Indian snacks`
- **Target Audience**: Everyone (Ages 13+)
- **Contact Details**:
  - Email: `support@cremen.in`
  - Website: `https://cremen.in`
  - Phone: `8948998413`

---

## 3. Google App Indexing & Digital Asset Links (`assetlinks.json`)

To enable Google Search & AI Overviews to link directly into CremenKart on Android devices, upload the following file to your website at:
`https://cremen.in/.well-known/assetlinks.json`

```json
[
  {
    "relation": ["delegate_permission/common.handle_all_urls"],
    "target": {
      "namespace": "android_app",
      "package_name": "com.cremen.cremenkart",
      "sha256_cert_fingerprints": [
        "PASTE_YOUR_RELEASE_KEYSTORE_SHA256_FINGERPRINT_HERE"
      ]
    }
  }
]
```

*(You can retrieve your release SHA-256 fingerprint by running: `keytool -list -v -keystore android/app/cremenkart-release.jks`)*

---

## 4. Graphics & Visual Assets (Ready in `store/`)
- [x] Hi-Res Icon (512×512 PNG, square, full bleed): `store/playstore_icon_512.png`
- [x] Feature Graphic (1024×500 PNG): `store/playstore_feature_graphic_1024x500.png`
- [ ] Phone Screenshots: Capture 4-6 screens (Home, Menu Catalog, Product Detail with Reviews, Cart, Order Status).
