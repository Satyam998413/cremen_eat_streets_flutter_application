import 'dart:io';
import 'dart:math' as math;
import 'package:image/image.dart' as img;

void main() {
  final outputDir = Directory('store/screenshots');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // Load logo
  final logoFile = File('assets/images/cremen_logo.png');
  final logoImg = img.decodeImage(logoFile.readAsBytesSync())!;

  print('Loaded logo: ${logoImg.width}x${logoImg.height}');

  final screens = [
    _ScreenMeta(
      id: 1,
      tagline: "SURAT'S AUTHENTIC STREET FOOD",
      subtitle: "Fresh, Spicy & Made to Order Straight from the Cart",
      accentColor: const [249, 115, 22], // #F97316
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawSplashScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
    _ScreenMeta(
      id: 2,
      tagline: "EXPLORE THE FRESH MENU",
      subtitle: "Sev Khamani, Bhel Puri, Chaat & Farsan",
      accentColor: const [234, 88, 12], // #EA580C
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawHomeScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
    _ScreenMeta(
      id: 3,
      tagline: "CUSTOMIZED TO YOUR TASTE",
      subtitle: "Spicy Level, Jain Prep & Verified Customer Reviews",
      accentColor: const [217, 70, 239], // purple-pink
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawProductDetailScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
    _ScreenMeta(
      id: 4,
      tagline: "PICKUP OR LOCAL DELIVERY",
      subtitle: "Order Ahead to Skip the Queue or Get Hot Delivery",
      accentColor: const [16, 185, 129], // emerald
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawCartScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
    _ScreenMeta(
      id: 5,
      tagline: "INSTANT UPI & CARD PAYMENTS",
      subtitle: "Powered by Razorpay: GPay, PhonePe, Paytm & Cards",
      accentColor: const [59, 130, 246], // blue
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawCheckoutScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
    _ScreenMeta(
      id: 6,
      tagline: "REAL-TIME ORDER TRACKING",
      subtitle: "Track Live From Cart Preparation to Your Doorstep",
      accentColor: const [245, 158, 11], // amber
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawTrackingScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
    _ScreenMeta(
      id: 7,
      tagline: "EASY 1-TAP REORDERING",
      subtitle: "Never Miss Your Favorite Evening Snacks",
      accentColor: const [239, 68, 68], // red
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawOrderHistoryScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
    _ScreenMeta(
      id: 8,
      tagline: "PAN-INDIA SNACKS SHIPPING",
      subtitle: "Authentic Gujarati Namkeen Delivered Anywhere in India",
      accentColor: const [99, 102, 241], // indigo
      drawContent: (canvas, phoneX, phoneY, phoneW, phoneH) {
        _drawProfileScreen(canvas, logoImg, phoneX, phoneY, phoneW, phoneH);
      },
    ),
  ];

  for (final meta in screens) {
    final image = _renderFullScreenshot(meta);
    final outFile = File('store/screenshots/screenshot_${meta.id}.png');
    outFile.writeAsBytesSync(img.encodePng(image));
    print('Generated screenshot_${meta.id}.png (1080x2400)');
  }

  print('All 8 Google Play Store screenshots generated successfully!');
}

class _ScreenMeta {
  final int id;
  final String tagline;
  final String subtitle;
  final List<int> accentColor;
  final Function(img.Image canvas, int phoneX, int phoneY, int phoneW, int phoneH) drawContent;

  _ScreenMeta({
    required this.id,
    required this.tagline,
    required this.subtitle,
    required this.accentColor,
    required this.drawContent,
  });
}

img.Image _renderFullScreenshot(_ScreenMeta meta) {
  const width = 1080;
  const height = 2400;
  final canvas = img.Image(width: width, height: height, numChannels: 4);

  // Background gradient: dark rich slate (#0F172A) with a warm top glow
  for (int y = 0; y < height; y++) {
    final t = y / height;
    final r = (15 + (1.0 - t) * (meta.accentColor[0] * 0.25)).round().clamp(0, 255);
    final g = (23 + (1.0 - t) * (meta.accentColor[1] * 0.25)).round().clamp(0, 255);
    final b = (42 + (1.0 - t) * (meta.accentColor[2] * 0.25)).round().clamp(0, 255);
    for (int x = 0; x < width; x++) {
      canvas.setPixel(x, y, img.ColorRgb8(r, g, b));
    }
  }

  // Draw header badge
  _drawPill(canvas, 1080 ~/ 2, 130, 420, 56, [255, 255, 255, 35]);
  img.drawString(
    canvas,
    'CREMENKART • SURAT',
    font: img.arial24,
    x: 540 - 140,
    y: 116,
    color: img.ColorRgb8(254, 215, 170),
  );

  // Draw Headline (Tagline)
  img.drawString(
    canvas,
    meta.tagline,
    font: img.arial48,
    x: 540 - (meta.tagline.length * 14),
    y: 210,
    color: img.ColorRgb8(255, 255, 255),
  );

  // Draw Subtitle
  img.drawString(
    canvas,
    meta.subtitle,
    font: img.arial24,
    x: 540 - (meta.subtitle.length * 7),
    y: 290,
    color: img.ColorRgb8(203, 213, 225),
  );

  // Phone Mockup Dimensions
  const phoneW = 860;
  const phoneH = 1820;
  const phoneX = (1080 - phoneW) ~/ 2;
  const phoneY = 380;

  // Phone Outer Border (Bezel)
  _drawRoundedRect(canvas, phoneX - 12, phoneY - 12, phoneW + 24, phoneH + 24, 64, [30, 41, 59]);
  _drawRoundedRect(canvas, phoneX - 4, phoneY - 4, phoneW + 8, phoneH + 8, 56, [15, 23, 42]);

  // Phone Screen Content
  meta.drawContent(canvas, phoneX, phoneY, phoneW, phoneH);

  // Phone Notch/Dynamic Island
  _drawPill(canvas, 540, phoneY + 36, 170, 44, [0, 0, 0, 255]);

  return canvas;
}

// -------------------------------------------------------------
// Individual Screen Renderers
// -------------------------------------------------------------

void _drawSplashScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  // Splash background gradient: orange #F97316 to #F59E0B
  for (int y = py; y < py + ph; y++) {
    final t = (y - py) / ph;
    final r = (249 - t * 10).round();
    final g = (115 + t * 45).round();
    final b = (22 + t * 10).round();
    for (int x = px; x < px + pw; x++) {
      canvas.setPixel(x, y, img.ColorRgb8(r, g, b));
    }
  }

  // Draw Logo in center
  final logoSize = 460;
  final resizedLogo = img.copyResize(logo, width: logoSize, height: logoSize, interpolation: img.Interpolation.cubic);
  final lx = px + (pw - logoSize) ~/ 2;
  final ly = py + (ph ~/ 2) - 340;
  img.compositeImage(canvas, resizedLogo, dstX: lx, dstY: ly);

  // Splash Title
  img.drawString(canvas, 'CremenKart', font: img.arial48, x: px + (pw ~/ 2) - 135, y: ly + logoSize + 40, color: img.ColorRgb8(255, 255, 255));
  img.drawString(canvas, 'Surat Ka Swadist Street Food 🍽️', font: img.arial24, x: px + (pw ~/ 2) - 180, y: ly + logoSize + 110, color: img.ColorRgb8(255, 247, 237));
  img.drawString(canvas, 'By Satyam Baranwal', font: img.arial24, x: px + (pw ~/ 2) - 110, y: py + ph - 120, color: img.ColorRgb8(254, 215, 170));
}

void _drawHomeScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  // White/light-gray background
  _fillRect(canvas, px, py, pw, ph, [248, 250, 252]);

  // App Bar
  _fillRect(canvas, px, py, pw, 170, [255, 255, 255]);
  img.drawString(canvas, 'CremenKart', font: img.arial48, x: px + 40, y: py + 75, color: img.ColorRgb8(234, 88, 12));
  img.drawString(canvas, '📍 Adajan Gam, Surat • Cart Open', font: img.arial24, x: px + 40, y: py + 130, color: img.ColorRgb8(100, 116, 139));

  // Search Bar
  _drawRoundedRect(canvas, px + 36, py + 195, pw - 72, 88, 24, [241, 245, 249]);
  img.drawString(canvas, '🔍  Search bhel, sev puri, chaat, khaman...', font: img.arial24, x: px + 64, y: py + 225, color: img.ColorRgb8(148, 163, 184));

  // Promo Banner
  _drawRoundedRect(canvas, px + 36, py + 310, pw - 72, 230, 32, [249, 115, 22]);
  img.drawString(canvas, 'FLAT 20% OFF FIRST ORDER', font: img.arial48, x: px + 68, y: py + 345, color: img.ColorRgb8(255, 255, 255));
  img.drawString(canvas, 'Use code CREMENFIRST on authentic street food', font: img.arial24, x: px + 68, y: py + 415, color: img.ColorRgb8(255, 237, 213));
  _drawPill(canvas, px + 170, py + 480, 200, 52, [255, 255, 255, 255]);
  img.drawString(canvas, 'Order Now', font: img.arial24, x: px + 115, y: py + 468, color: img.ColorRgb8(234, 88, 12));

  // Category Pills
  final categories = ['All (24)', 'Fresh Street Food', 'Packaged Snacks', 'Beverages'];
  int cx = px + 36;
  for (int i = 0; i < categories.length; i++) {
    final w = categories[i].length * 15 + 36;
    final isSelected = i == 0;
    _drawPill(canvas, cx + (w ~/ 2), py + 580, w, 60, isSelected ? [234, 88, 12, 255] : [226, 232, 240, 255]);
    img.drawString(
      canvas,
      categories[i],
      font: img.arial24,
      x: cx + 18,
      y: py + 568,
      color: isSelected ? img.ColorRgb8(255, 255, 255) : img.ColorRgb8(71, 85, 105),
    );
    cx += w + 20;
  }

  // Food Cards Grid (2x2)
  final items = [
    _FoodItem('Special Surti Bhel', '₹60', '4.9 ★ (128)', true),
    _FoodItem('Sev Khamani (250g)', '₹75', '4.8 ★ (94)', true),
    _FoodItem('Dahi Puri Chaat', '₹70', '4.9 ★ (210)', true),
    _FoodItem('Nylon Farsan (Pack)', '₹90', '4.7 ★ (85)', true),
  ];

  final cardW = (pw - 96) ~/ 2;
  const cardH = 430;
  for (int i = 0; i < 4; i++) {
    final row = i ~/ 2;
    final col = i % 2;
    final bx = px + 36 + col * (cardW + 24);
    final by = py + 640 + row * (cardH + 24);

    _drawRoundedRect(canvas, bx, by, cardW, cardH, 28, [255, 255, 255]);
    // Image placeholder
    _drawRoundedRect(canvas, bx + 16, by + 16, cardW - 32, 220, 20, [254, 215, 170]);
    img.drawString(canvas, '🍽️ FRESH', font: img.arial24, x: bx + 36, y: by + 110, color: img.ColorRgb8(194, 65, 12));

    // Title & Rating
    img.drawString(canvas, items[i].name, font: img.arial24, x: bx + 20, y: by + 252, color: img.ColorRgb8(15, 23, 42));
    img.drawString(canvas, items[i].rating, font: img.arial24, x: bx + 20, y: by + 295, color: img.ColorRgb8(234, 88, 12));

    // Price & ADD Button
    img.drawString(canvas, items[i].price, font: img.arial48, x: bx + 20, y: by + 345, color: img.ColorRgb8(15, 23, 42));
    _drawRoundedRect(canvas, bx + cardW - 130, by + 345, 110, 56, 16, [234, 88, 12]);
    img.drawString(canvas, 'ADD', font: img.arial24, x: bx + cardW - 98, y: by + 360, color: img.ColorRgb8(255, 255, 255));
  }

  // Bottom Navigation Bar
  _drawBottomNav(canvas, px, py + ph - 130, pw, 130, 0);
}

void _drawProductDetailScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  _fillRect(canvas, px, py, pw, ph, [255, 255, 255]);

  // Product Image Hero
  _fillRect(canvas, px, py, pw, 580, [254, 215, 170]);
  final heroSize = 360;
  final resizedHero = img.copyResize(logo, width: heroSize, height: heroSize);
  img.compositeImage(canvas, resizedHero, dstX: px + (pw - heroSize) ~/ 2, dstY: py + 120);

  // Top Back & Share buttons
  _drawPill(canvas, px + 80, py + 80, 72, 72, [255, 255, 255, 220]);
  img.drawString(canvas, '←', font: img.arial48, x: px + 66, y: py + 56, color: img.ColorRgb8(15, 23, 42));

  // Details Container
  final dy = py + 540;
  _drawRoundedRect(canvas, px, dy, pw, ph - 540, 48, [255, 255, 255]);

  img.drawString(canvas, 'Special Surti Bhel Puri', font: img.arial48, x: px + 44, y: dy + 45, color: img.ColorRgb8(15, 23, 42));
  img.drawString(canvas, 'Crispy puffed rice, tangy tamarind & spicy mint chutney, onions, and sev.', font: img.arial24, x: px + 44, y: dy + 115, color: img.ColorRgb8(100, 116, 139));
  img.drawString(canvas, '₹60', font: img.arial48, x: px + 44, y: dy + 165, color: img.ColorRgb8(234, 88, 12));

  // Spicy Level Selector
  img.drawString(canvas, 'Choose Spicy Level', font: img.arial24, x: px + 44, y: dy + 250, color: img.ColorRgb8(15, 23, 42));
  final spiceOptions = ['Mild 🌶️', 'Medium 🌶️🌶️', 'Extra Spicy 🌶️🌶️🌶️'];
  int sx = px + 44;
  for (int i = 0; i < spiceOptions.length; i++) {
    final w = 230;
    final isSelected = i == 1;
    _drawRoundedRect(canvas, sx, dy + 295, w, 68, 20, isSelected ? [254, 215, 170] : [241, 245, 249]);
    img.drawString(canvas, spiceOptions[i], font: img.arial24, x: sx + 22, y: dy + 316, color: isSelected ? img.ColorRgb8(194, 65, 12) : img.ColorRgb8(71, 85, 105));
    sx += w + 24;
  }

  // Jain Preparation Option
  _drawRoundedRect(canvas, px + 44, dy + 400, pw - 88, 96, 24, [248, 250, 252]);
  img.drawString(canvas, '🌱  Jain Preparation (No onion & garlic)', font: img.arial24, x: px + 76, y: dy + 434, color: img.ColorRgb8(15, 23, 42));
  _drawPill(canvas, px + pw - 120, dy + 448, 70, 42, [16, 185, 129, 255]);

  // Customer Reviews Highlight
  _drawRoundedRect(canvas, px + 44, dy + 530, pw - 88, 220, 28, [255, 247, 237]);
  img.drawString(canvas, 'Customer Reviews (4.9 ★ • 128 Reviews)', font: img.arial24, x: px + 76, y: dy + 560, color: img.ColorRgb8(154, 52, 18));
  img.drawString(canvas, '"Best authentic bhel in Surat! Just like eating directly at the cart."', font: img.arial24, x: px + 76, y: dy + 610, color: img.ColorRgb8(67, 20, 7));
  img.drawString(canvas, '— Rahul Patel • 2 days ago', font: img.arial24, x: px + 76, y: dy + 665, color: img.ColorRgb8(154, 52, 18));

  // Bottom Add to Cart Bar
  _fillRect(canvas, px, py + ph - 160, pw, 160, [255, 255, 255]);
  _drawRoundedRect(canvas, px + 44, py + ph - 130, pw - 88, 96, 28, [234, 88, 12]);
  img.drawString(canvas, 'ADD TO CART • ₹60', font: img.arial48, x: px + (pw ~/ 2) - 170, y: py + ph - 105, color: img.ColorRgb8(255, 255, 255));
}

void _drawCartScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  _fillRect(canvas, px, py, pw, ph, [248, 250, 252]);

  // Top Bar
  _fillRect(canvas, px, py, pw, 160, [255, 255, 255]);
  img.drawString(canvas, 'Your Cart (3 items)', font: img.arial48, x: px + 44, y: py + 75, color: img.ColorRgb8(15, 23, 42));

  // Fulfillment Mode Toggle
  _drawRoundedRect(canvas, px + 44, py + 185, pw - 88, 90, 28, [226, 232, 240]);
  _drawRoundedRect(canvas, px + 50, py + 191, (pw - 100) ~/ 2, 78, 24, [234, 88, 12]);
  img.drawString(canvas, '🛵 Delivery', font: img.arial24, x: px + 140, y: py + 215, color: img.ColorRgb8(255, 255, 255));
  img.drawString(canvas, '🛍️ Pickup', font: img.arial24, x: px + pw ~/ 2 + 100, y: py + 215, color: img.ColorRgb8(71, 85, 105));

  // Cart Items
  final cart = [
    _CartItem('Surti Special Bhel', 'Medium Spicy', '₹60', 2),
    _CartItem('Sev Khamani', 'With Sev & Pomegranate', '₹75', 1),
    _CartItem('Masala Chaas', 'Cold Beverage', '₹25', 2),
  ];

  int cy = py + 305;
  for (final item in cart) {
    _drawRoundedRect(canvas, px + 44, cy, pw - 88, 170, 28, [255, 255, 255]);
    img.drawString(canvas, item.title, font: img.arial24, x: px + 76, y: cy + 35, color: img.ColorRgb8(15, 23, 42));
    img.drawString(canvas, item.sub, font: img.arial24, x: px + 76, y: cy + 75, color: img.ColorRgb8(100, 116, 139));
    img.drawString(canvas, item.price, font: img.arial48, x: px + 76, y: cy + 110, color: img.ColorRgb8(234, 88, 12));

    // Quantity Selector
    _drawRoundedRect(canvas, px + pw - 240, cy + 55, 150, 60, 18, [241, 245, 249]);
    img.drawString(canvas, '—   ${item.qty}   +', font: img.arial24, x: px + pw - 215, y: cy + 72, color: img.ColorRgb8(15, 23, 42));

    cy += 195;
  }

  // Bill Summary
  _drawRoundedRect(canvas, px + 44, cy + 20, pw - 88, 300, 32, [255, 255, 255]);
  img.drawString(canvas, 'Bill Summary', font: img.arial24, x: px + 76, y: cy + 55, color: img.ColorRgb8(15, 23, 42));
  img.drawString(canvas, 'Item Total:                          ₹245', font: img.arial24, x: px + 76, y: cy + 105, color: img.ColorRgb8(71, 85, 105));
  img.drawString(canvas, 'Delivery Fee:                       FREE', font: img.arial24, x: px + 76, y: cy + 150, color: img.ColorRgb8(16, 185, 129));
  img.drawString(canvas, 'Taxes & Packing:                  ₹15', font: img.arial24, x: px + 76, y: cy + 195, color: img.ColorRgb8(71, 85, 105));
  img.drawString(canvas, 'To Pay:                               ₹260', font: img.arial48, x: px + 76, y: cy + 245, color: img.ColorRgb8(15, 23, 42));

  // Bottom Checkout Button
  _fillRect(canvas, px, py + ph - 160, pw, 160, [255, 255, 255]);
  _drawRoundedRect(canvas, px + 44, py + ph - 130, pw - 88, 96, 28, [234, 88, 12]);
  img.drawString(canvas, 'PROCEED TO CHECKOUT • ₹260', font: img.arial48, x: px + (pw ~/ 2) - 245, y: py + ph - 105, color: img.ColorRgb8(255, 255, 255));
}

void _drawCheckoutScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  _fillRect(canvas, px, py, pw, ph, [248, 250, 252]);

  // Top Bar
  _fillRect(canvas, px, py, pw, 160, [255, 255, 255]);
  img.drawString(canvas, 'Checkout', font: img.arial48, x: px + 44, y: py + 75, color: img.ColorRgb8(15, 23, 42));

  // Delivery Address Card
  _drawRoundedRect(canvas, px + 44, py + 185, pw - 88, 210, 28, [255, 255, 255]);
  img.drawString(canvas, '📍 Delivery Address', font: img.arial24, x: px + 76, y: py + 220, color: img.ColorRgb8(234, 88, 12));
  img.drawString(canvas, 'Home • Flat 402, Shivalik Residency', font: img.arial24, x: px + 76, y: py + 265, color: img.ColorRgb8(15, 23, 42));
  img.drawString(canvas, 'Adajan Gam, Surat - 395009', font: img.arial24, x: px + 76, y: py + 305, color: img.ColorRgb8(100, 116, 139));
  img.drawString(canvas, 'Contact: +91 89489 98413', font: img.arial24, x: px + 76, y: py + 345, color: img.ColorRgb8(100, 116, 139));

  // Payment Options Header
  img.drawString(canvas, 'Select Payment Method', font: img.arial24, x: px + 50, y: py + 435, color: img.ColorRgb8(15, 23, 42));

  // Payment Tiles
  final paymentMethods = [
    _PayMethod('Google Pay / PhonePe UPI', 'Instant UPI payment via Razorpay', true),
    _PayMethod('Paytm Wallet & UPI', 'Direct wallet or UPI ID', false),
    _PayMethod('Debit & Credit Cards', 'Visa, Mastercard, RuPay', false),
    _PayMethod('Netbanking', 'All Indian banks supported', false),
  ];

  int pyPos = py + 480;
  for (final m in paymentMethods) {
    _drawRoundedRect(canvas, px + 44, pyPos, pw - 88, 130, 24, [255, 255, 255]);
    _drawPill(canvas, px + 88, pyPos + 65, 42, 42, m.selected ? [16, 185, 129, 255] : [203, 213, 225, 255]);
    img.drawString(canvas, m.title, font: img.arial24, x: px + 130, y: pyPos + 35, color: img.ColorRgb8(15, 23, 42));
    img.drawString(canvas, m.sub, font: img.arial24, x: px + 130, y: pyPos + 75, color: img.ColorRgb8(100, 116, 139));
    pyPos += 150;
  }

  // Razorpay Security Badge
  _drawRoundedRect(canvas, px + 44, pyPos + 20, pw - 88, 100, 24, [239, 246, 255]);
  img.drawString(canvas, '🔒 100% Secure 256-bit Encrypted Payment by Razorpay', font: img.arial24, x: px + 68, y: pyPos + 58, color: img.ColorRgb8(30, 64, 175));

  // Pay Button
  _fillRect(canvas, px, py + ph - 160, pw, 160, [255, 255, 255]);
  _drawRoundedRect(canvas, px + 44, py + ph - 130, pw - 88, 96, 28, [16, 185, 129]);
  img.drawString(canvas, 'PAY ₹260 & PLACE ORDER', font: img.arial48, x: px + (pw ~/ 2) - 235, y: py + ph - 105, color: img.ColorRgb8(255, 255, 255));
}

void _drawTrackingScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  _fillRect(canvas, px, py, pw, ph, [248, 250, 252]);

  // Top Bar
  _fillRect(canvas, px, py, pw, 160, [255, 255, 255]);
  img.drawString(canvas, 'Order Tracking', font: img.arial48, x: px + 44, y: py + 75, color: img.ColorRgb8(15, 23, 42));

  // Live Status Hero
  _drawRoundedRect(canvas, px + 44, py + 185, pw - 88, 260, 32, [249, 115, 22]);
  img.drawString(canvas, 'ORDER #CK-8948', font: img.arial24, x: px + 76, y: py + 225, color: img.ColorRgb8(254, 215, 170));
  img.drawString(canvas, 'Preparing Live at Cart! 👨‍🍳', font: img.arial48, x: px + 76, y: py + 270, color: img.ColorRgb8(255, 255, 255));
  img.drawString(canvas, 'Estimated Delivery: 18–22 mins', font: img.arial24, x: px + 76, y: py + 350, color: img.ColorRgb8(255, 247, 237));
  img.drawString(canvas, 'Fresh, spicy, and made to order.', font: img.arial24, x: px + 76, y: py + 390, color: img.ColorRgb8(255, 237, 213));

  // Stepper Card
  _drawRoundedRect(canvas, px + 44, py + 480, pw - 88, 540, 32, [255, 255, 255]);
  img.drawString(canvas, 'Order Status', font: img.arial24, x: px + 76, y: py + 520, color: img.ColorRgb8(15, 23, 42));

  final steps = [
    _Step('Order Confirmed', 'Payment received via UPI', true),
    _Step('Preparing at Cart', 'Fresh spices & chutney being blended', true),
    _Step('Out for Delivery', 'Rider on the way to Adajan', false),
    _Step('Delivered', 'Enjoy your authentic Surat street food!', false),
  ];

  int sy = py + 580;
  for (final step in steps) {
    _drawPill(canvas, px + 88, sy + 30, 48, 48, step.done ? [16, 185, 129, 255] : [226, 232, 240, 255]);
    img.drawString(canvas, step.title, font: img.arial24, x: px + 130, y: sy + 15, color: step.done ? img.ColorRgb8(15, 23, 42) : img.ColorRgb8(148, 163, 184));
    img.drawString(canvas, step.sub, font: img.arial24, x: px + 130, y: sy + 48, color: img.ColorRgb8(100, 116, 139));
    sy += 105;
  }

  // Direct Contact Cart Button
  _drawRoundedRect(canvas, px + 44, py + 1050, pw - 88, 120, 28, [255, 255, 255]);
  img.drawString(canvas, '📞 Need help? Call Cart Directly', font: img.arial24, x: px + 76, y: py + 1090, color: img.ColorRgb8(234, 88, 12));
  img.drawString(canvas, 'Satyam Baranwal: 8948998413', font: img.arial24, x: px + 76, y: py + 1125, color: img.ColorRgb8(100, 116, 139));
}

void _drawOrderHistoryScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  _fillRect(canvas, px, py, pw, ph, [248, 250, 252]);

  // Top Bar
  _fillRect(canvas, px, py, pw, 160, [255, 255, 255]);
  img.drawString(canvas, 'Order History', font: img.arial48, x: px + 44, y: py + 75, color: img.ColorRgb8(15, 23, 42));

  // Orders List
  final orders = [
    _HistOrder('CK-8948', 'Yesterday, 7:15 PM', '2x Special Bhel, 1x Khaman', '₹260', 'Delivered'),
    _HistOrder('CK-8812', '4 Nov, 6:30 PM', '1x Sev Puri, 2x Dahi Puri', '₹190', 'Delivered'),
    _HistOrder('CK-8720', '1 Nov, 8:00 PM', '4x Nylon Farsan (Packaged)', '₹360', 'Delivered'),
    _HistOrder('CK-8605', '28 Oct, 5:45 PM', '2x Khamani, 2x Chaas', '₹200', 'Delivered'),
  ];

  int hy = py + 185;
  for (final o in orders) {
    _drawRoundedRect(canvas, px + 44, hy, pw - 88, 240, 28, [255, 255, 255]);
    img.drawString(canvas, 'Order #${o.id}', font: img.arial24, x: px + 76, y: hy + 35, color: img.ColorRgb8(15, 23, 42));
    _drawPill(canvas, px + pw - 140, hy + 45, 120, 44, [220, 252, 231, 255]);
    img.drawString(canvas, o.status, font: img.arial24, x: px + pw - 180, y: hy + 35, color: img.ColorRgb8(22, 101, 52));

    img.drawString(canvas, o.date, font: img.arial24, x: px + 76, y: hy + 80, color: img.ColorRgb8(100, 116, 139));
    img.drawString(canvas, o.items, font: img.arial24, x: px + 76, y: hy + 120, color: img.ColorRgb8(15, 23, 42));

    img.drawString(canvas, o.price, font: img.arial48, x: px + 76, y: hy + 175, color: img.ColorRgb8(234, 88, 12));
    _drawRoundedRect(canvas, px + pw - 220, hy + 165, 140, 56, 18, [254, 215, 170]);
    img.drawString(canvas, 'Reorder', font: img.arial24, x: px + pw - 195, y: hy + 180, color: img.ColorRgb8(194, 65, 12));

    hy += 265;
  }

  _drawBottomNav(canvas, px, py + ph - 130, pw, 130, 1);
}

void _drawProfileScreen(img.Image canvas, img.Image logo, int px, int py, int pw, int ph) {
  _fillRect(canvas, px, py, pw, ph, [248, 250, 252]);

  // Profile Header Card
  _fillRect(canvas, px, py, pw, 320, [255, 255, 255]);
  _drawPill(canvas, px + 120, py + 160, 120, 120, [254, 215, 170, 255]);
  img.drawString(canvas, '👤', font: img.arial48, x: px + 95, y: py + 135, color: img.ColorRgb8(194, 65, 12));

  img.drawString(canvas, 'Satyam Baranwal', font: img.arial48, x: px + 210, y: py + 120, color: img.ColorRgb8(15, 23, 42));
  img.drawString(canvas, 'satyam@cremen.in • Surat', font: img.arial24, x: px + 210, y: py + 180, color: img.ColorRgb8(100, 116, 139));
  img.drawString(canvas, '⭐ CremenKart Gold Foodie', font: img.arial24, x: px + 210, y: py + 220, color: img.ColorRgb8(234, 88, 12));

  // Pan-India Shipping Promotion
  _drawRoundedRect(canvas, px + 44, py + 350, pw - 88, 200, 32, [99, 102, 241]);
  img.drawString(canvas, '📦 ALL-INDIA SNACKS SHIPPING', font: img.arial48, x: px + 76, y: py + 390, color: img.ColorRgb8(255, 255, 255));
  img.drawString(canvas, 'Send authentic Surat farsan & snacks to any pincode in India.', font: img.arial24, x: px + 76, y: py + 455, color: img.ColorRgb8(224, 231, 255));
  img.drawString(canvas, 'Freshly packed & airtight sealed • Delivered in 3-5 days.', font: img.arial24, x: px + 76, y: py + 495, color: img.ColorRgb8(199, 210, 254));

  // Settings Menu Items
  final settings = [
    _Setting('📍 Saved Delivery Addresses', 'Manage home and office addresses'),
    _Setting('💳 Payment Methods & UPI', 'Saved cards & UPI preferences'),
    _Setting('🌙 Dark Mode', 'Toggle eye-friendly dark theme'),
    _Setting('💬 24/7 WhatsApp Support', 'Instant help with orders & inquiries'),
    _Setting('📜 Terms & Privacy Policy', 'cremen.in terms & data privacy'),
  ];

  int sy = py + 580;
  for (final s in settings) {
    _drawRoundedRect(canvas, px + 44, sy, pw - 88, 115, 24, [255, 255, 255]);
    img.drawString(canvas, s.title, font: img.arial24, x: px + 76, y: sy + 28, color: img.ColorRgb8(15, 23, 42));
    img.drawString(canvas, s.sub, font: img.arial24, x: px + 76, y: sy + 65, color: img.ColorRgb8(100, 116, 139));
    sy += 135;
  }

  _drawBottomNav(canvas, px, py + ph - 130, pw, 130, 2);
}

// -------------------------------------------------------------
// Drawing Helpers
// -------------------------------------------------------------

void _drawBottomNav(img.Image canvas, int x, int y, int w, int h, int activeIdx) {
  _fillRect(canvas, x, y, w, h, [255, 255, 255]);
  final tabs = ['Menu', 'Orders', 'Account'];
  final segW = w ~/ tabs.length;
  for (int i = 0; i < tabs.length; i++) {
    final tx = x + i * segW + (segW ~/ 2) - 40;
    final isActive = i == activeIdx;
    img.drawString(
      canvas,
      tabs[i],
      font: img.arial24,
      x: tx,
      y: y + 45,
      color: isActive ? img.ColorRgb8(234, 88, 12) : img.ColorRgb8(148, 163, 184),
    );
  }
}

void _fillRect(img.Image canvas, int x, int y, int w, int h, List<int> color) {
  final rgb = img.ColorRgb8(color[0], color[1], color[2]);
  for (int cy = y; cy < y + h && cy < canvas.height; cy++) {
    for (int cx = x; cx < x + w && cx < canvas.width; cx++) {
      canvas.setPixel(cx, cy, rgb);
    }
  }
}

void _drawRoundedRect(img.Image canvas, int x, int y, int w, int h, int radius, List<int> color) {
  final rgb = img.ColorRgb8(color[0], color[1], color[2]);
  final r2 = radius * radius;
  for (int cy = y; cy < y + h && cy < canvas.height; cy++) {
    for (int cx = x; cx < x + w && cx < canvas.width; cx++) {
      // Check rounded corners
      int dx = 0, dy = 0;
      if (cx < x + radius) dx = cx - (x + radius);
      if (cx > x + w - radius) dx = cx - (x + w - radius);
      if (cy < y + radius) dy = cy - (y + radius);
      if (cy > y + h - radius) dy = cy - (y + h - radius);

      if (dx * dx + dy * dy <= r2) {
        canvas.setPixel(cx, cy, rgb);
      }
    }
  }
}

void _drawPill(img.Image canvas, int cx, int cy, int w, int h, List<int> color) {
  _drawRoundedRect(canvas, cx - w ~/ 2, cy - h ~/ 2, w, h, h ~/ 2, color);
}

class _FoodItem {
  final String name, price, rating;
  final bool isVeg;
  _FoodItem(this.name, this.price, this.rating, this.isVeg);
}

class _CartItem {
  final String title, sub, price;
  final int qty;
  _CartItem(this.title, this.sub, this.price, this.qty);
}

class _PayMethod {
  final String title, sub;
  final bool selected;
  _PayMethod(this.title, this.sub, this.selected);
}

class _Step {
  final String title, sub;
  final bool done;
  _Step(this.title, this.sub, this.done);
}

class _HistOrder {
  final String id, date, items, price, status;
  _HistOrder(this.id, this.date, this.items, this.price, this.status);
}

class _Setting {
  final String title, sub;
  _Setting(this.title, this.sub);
}
