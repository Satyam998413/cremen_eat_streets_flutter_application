# Comprehensive Plan: AI-Driven E-Commerce App Development & Architecture
**Target Store Platform:** [cremeneatstreet.shop](https://cremeneatstreet.shop/)  
**Technology Stack:** Flutter (Frontend), Hive DB (Local Persistence & Cart), Razorpay (Payment Gateway), AI-Assisted Workflows

---

## Executive Summary

This master plan outlines the step-by-step blueprint to build, test, and deploy a high-performance cross-platform mobile e-commerce application for **Cremen Eat Streets**. By leveraging modern AI developer tools (Cursor, Claude, Copilot, ChatGPT) along with Flutter, Hive for local storage, and Razorpay for seamless payment processing, this implementation schedule ensures efficient, fault-tolerant execution.

---

## Architectural Overview

```
 ┌─────────────────────────────────────────────────────────┐
 │                      Flutter UI                         │
 │   (Catalog, Product Detail, Cart, Checkout, Profile)    │
 └───────────┬─────────────────────────────────┬───────────┘
             │                                 │
             ▼                                 ▼
 ┌───────────────────────┐         ┌───────────────────────┐
 │ Hive Local Storage    │         │ Razorpay Gateway      │
 │ • Cart Items          │         │ • Order Initiation    │
 │ • User Preferences    │         │ • Payment Verification│
 │ • Offline Cache       │         │ • Webhooks / API      │
 └───────────────────────┘         └───────────────────────┘
```

---

## Phase 1: AI Prompting & Project Scaffolding

### Task 1.1: Project Setup & Environment Configuration
* **Objective:** Initialize the Flutter repository with essential dependencies and optimal folder structure using AI scaffolding.
* **AI Instructions / Prompts:**
  > *"Generate a clean Flutter architecture template with feature-first folder structure (`lib/features/catalog`, `lib/features/cart`, `lib/features/checkout`, `lib/core/services`). Set up `pubspec.yaml` with `hive`, `hive_flutter`, `razorpay_flutter`, and `provider` or `flutter_bloc` for state management."*

* **Dependencies (`pubspec.yaml`):**
  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    hive: ^2.2.3
    hive_flutter: ^1.1.0
    razorpay_flutter: ^1.3.7
    provider: ^6.1.2
    http: ^1.2.0

  dev_dependencies:
    flutter_test:
      sdk: flutter
    hive_generator: ^2.0.1
    build_runner: ^2.4.8
  ```

---

## Phase 2: Local Database Architecture with Hive

Since Hive is **not built into Flutter**, it must be explicitly configured as an external NoSQL database package.

### Task 2.1: Define Data Models & TypeAdapters
* **Objective:** Map products and cart items into Hive objects using `hive_generator`.
* **Model Schema (`lib/models/cart_item.dart`):**
  ```dart
  import 'package:hive/hive.dart';

  part 'cart_item.g.dart';

  @HiveType(typeId: 0)
  class CartItem extends HiveObject {
    @HiveField(0)
    final String id;

    @HiveField(1)
    final String name;

    @HiveField(2)
    final double price;

    @HiveField(3)
    int quantity;

    @HiveField(4)
    final String imageUrl;

    CartItem({
      required this.id,
      required this.name,
      required this.price,
      required this.quantity,
      required this.imageUrl,
    });
  }
  ```

### Task 2.2: Hive Database Initialization & Operations
* **Objective:** Configure local initialization in `main.dart` and build CRUD services for shopping cart functionality.
* **AI Prompt:**
  > *"Create a HiveCartService in Flutter that opens a box named 'cart_box'. Provide methods to add items, update quantity, remove items, clear the cart, and calculate total price using standard Hive methods."*

---

## Phase 3: Web Scraping & AI Data Sync (cremeneatstreet.shop)

### Task 3.1: Catalog Ingestion & Asset Mapping
* **Objective:** Extract menu categories, item prices, descriptions, and media assets from [cremeneatstreet.shop](https://cremeneatstreet.shop/).
* **Step-by-step Actions:**
  1. Extract HTML/JSON product schema from the web domain.
  2. Map food categories (e.g., Special Bhel, Puri preparations, Combos).
  3. Store mock/initial catalog JSON structure inside local assets (`assets/data/products.json`) for instant offline-first rendering.

---

## Phase 4: UI/UX Implementation with AI Code Generation

### Task 4.1: Product Catalog & Menu Screen
* **Key Components:**
  * Categorized Grid / List View (Puri, Bhel, Special Offers).
  * Fast "Add to Cart" CTA buttons updating Hive storage instantly.
  * Search and dynamic filtering.

### Task 4.2: Dynamic Shopping Cart Screen
* **Key Components:**
  * Real-time listeners on `Hive.box('cart_box')` via `ValueListenableBuilder` or `Provider`.
  * Quantity modifier buttons (`+` / `-`).
  * Price breakdown summary (Subtotal, Offer discounts, Taxes, Delivery Fee).

---

## Phase 5: Razorpay Payment Gateway Integration

### Task 5.1: Native Android & iOS Configurations
* **Android (`android/app/build.gradle`):**
  * Ensure `minSdkVersion` is set to `19` or higher.
* **iOS (`ios/Podfile`):**
  * Ensure platform deployment target is `iOS 11.0` or above.

### Task 5.2: Checkout & Razorpay Event Listener Integration
* **Implementation Logic:**
  ```dart
  import 'package:flutter/material.dart';
  import 'package:razorpay_flutter/razorpay_flutter.dart';

  class PaymentService {
    late Razorpay _razorpay;

    void initialize({
      required Function(PaymentSuccessResponse) onSuccess,
      required Function(PaymentFailureResponse) onError,
      required Function(ExternalWalletResponse) onWallet,
    }) {
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onWallet);
    }

    void openCheckout({
      required double amount,
      required String storeName,
      required String description,
      required String contactNumber,
      required String email,
      required String razorpayApiKey,
    }) {
      var options = {
        'key': razorpayApiKey,
        'amount': (amount * 100).toInt(), // Amount in paise
        'name': storeName,
        'description': description,
        'prefill': {
          'contact': contactNumber,
          'email': email,
        },
        'external': {
          'wallets': ['paytm']
        }
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint('Razorpay Opening Error: $e');
      }
    }

    void dispose() {
      _razorpay.clear();
    }
  }
  ```

---

## Phase 6: Post-Payment Workflow & Order Lifecycle

```
[User Presses "Pay Now"] ──> [Razorpay Gateway Opens]
                                      │
                         ┌────────────┴────────────┐
                         ▼                         ▼
                  [Payment Success]         [Payment Failure]
                         │                         │
                         ▼                         ▼
                 [Clear Hive Cart]         [Show Snack/Alert]
                         │                         │
                         ▼                         ▼
              [Order Receipt Screen]       [Retry Payment]
```

### Task 6.1: Order Success Action Checklist
1. Receive `PaymentSuccessResponse.paymentId`.
2. Clear local cart via `HiveCartService.clearCart()`.
3. Save order details into a Hive `orders` box for user order history.
4. Route user to Order Confirmation Screen showing real-time delivery status.

---

## Phase 7: Testing, Deployment & Optimization

| Stage | Task Details | Tools |
| :--- | :--- | :--- |
| **Local Unit Testing** | Test Hive CRUD operations, Cart calculations, and Hive TypeAdapters. | Flutter Test |
| **Gateway Sandbox** | Perform test transactions using Razorpay Test Key (`rzp_test_...`). | Razorpay Sandbox |
| **Build Generation** | Generate Android APK / App Bundle and iOS IPA release builds. | Flutter CLI |
| **Store Release** | Submit to Google Play Store & Apple App Store. | Play Console / App Store Connect |

---
*Document prepared for Cremen Eat Streets E-Commerce Mobile Application.*
