import 'dart:io';
import 'dart:math' as math;
import 'package:image/image.dart' as img;

void main() {
  final userLogoPath = r'C:\Users\spbar\.gemini\antigravity\brain\8e6b7c76-264a-4569-b5ec-952adcf6b85c\.user_uploaded\media_1794055217108_538021ce.jpg';
  final rawSrc = img.decodeImage(File(userLogoPath).readAsBytesSync());
  if (rawSrc == null) {
    stderr.writeln('Error decoding source logo');
    exit(1);
  }

  stdout.writeln('Source image loaded: ${rawSrc.width}x${rawSrc.height}');

  final cx = 512.0;
  final cy = 512.0;

  // 1. Create full-bleed 1024x1024 square image without black corners / white squircle rim
  final fullSquare = img.Image.from(rawSrc);

  for (int y = 0; y < 1024; y++) {
    for (int x = 0; x < 1024; x++) {
      final p = fullSquare.getPixel(x, y);
      final isBlackCorner = p.r < 35 && p.g < 35 && p.b < 35;
      final isWhiteBorder = p.r > 230 && p.g > 230 && p.b > 230;

      final nearEdge = x < 65 || x > 958 || y < 65 || y > 958;
      final distCornerTL = math.sqrt(x * x + y * y);
      final distCornerTR = math.sqrt((1023 - x) * (1023 - x) + y * y);
      final distCornerBL = math.sqrt(x * x + (1023 - y) * (1023 - y));
      final distCornerBR = math.sqrt((1023 - x) * (1023 - x) + (1023 - y) * (1023 - y));
      final inCornerZone = distCornerTL < 185 || distCornerTR < 185 || distCornerBL < 185 || distCornerBR < 185;

      if ((nearEdge || inCornerZone) && (isBlackCorner || isWhiteBorder)) {
        final angle = math.atan2(y - cy, x - cx);
        const sampleR = 450.0;
        final sx = (cx + sampleR * math.cos(angle)).round().clamp(0, 1023);
        final sy = (cy + sampleR * math.sin(angle)).round().clamp(0, 1023);
        final sampleP = rawSrc.getPixel(sx, sy);
        fullSquare.setPixel(x, y, sampleP);
      }
    }
  }

  // Save assets/images/cremen_logo.png and cremen_logo.jpg
  final pngBytes = img.encodePng(fullSquare);
  final jpgBytes = img.encodeJpg(fullSquare, quality: 95);

  File('assets/images/cremen_logo.png').writeAsBytesSync(pngBytes);
  File('assets/images/cremen_logo.jpg').writeAsBytesSync(jpgBytes);
  stdout.writeln('Saved assets/images/cremen_logo.png and cremen_logo.jpg');

  // 2. Adaptive Icon Foreground:
  // Android adaptive icon requires a 1024x1024 canvas where key content lives inside the central ~66% circle.
  // The fullSquare already has the character + badge from ~216 to 781 px (565px span ~55% of canvas).
  // Scaling by 0.72 ensures plenty of breathing room for any squircle/circle mask without cropping.
  const canvasSize = 1024;
  const safeZoneScale = 0.72;
  final targetSize = (canvasSize * safeZoneScale).round();
  final resized = img.copyResize(
    fullSquare,
    width: targetSize,
    height: targetSize,
    interpolation: img.Interpolation.cubic,
  );

  // We make a circular/rounded version or centered emblem with rounded corners so the orange circle sits cleanly on the background
  final adaptiveFgCanvas = img.Image(
    width: canvasSize,
    height: canvasSize,
    numChannels: 4,
  );
  img.fill(adaptiveFgCanvas, color: img.ColorRgba8(0, 0, 0, 0));

  final offset = ((canvasSize - targetSize) / 2).round();

  // Composite resized artwork onto transparent canvas
  img.compositeImage(adaptiveFgCanvas, resized, dstX: offset, dstY: offset);
  File('assets/images/cremen_logo_adaptive_fg.png').writeAsBytesSync(img.encodePng(adaptiveFgCanvas));
  stdout.writeln('Saved assets/images/cremen_logo_adaptive_fg.png');

  // 3. Play Store Hi-Res Icon (512x512 PNG, square, no rounded corners)
  final playStore512 = img.copyResize(
    fullSquare,
    width: 512,
    height: 512,
    interpolation: img.Interpolation.cubic,
  );
  final storeDir = Directory('store');
  if (!storeDir.existsSync()) {
    storeDir.createSync(recursive: true);
  }
  File('store/playstore_icon_512.png').writeAsBytesSync(img.encodePng(playStore512));
  stdout.writeln('Saved store/playstore_icon_512.png (512x512 square)');

  // 4. Play Store Feature Graphic (1024x500 PNG)
  final featureGraphic = img.Image(width: 1024, height: 500, numChannels: 4);
  // Fill background with radiant orange gradient matching brand
  for (int y = 0; y < 500; y++) {
    for (int x = 0; x < 1024; x++) {
      final dist = math.sqrt((x - 512) * (x - 512) + (y - 250) * (y - 250));
      // Base vibrant orange #EF6523 (239, 101, 35) to #F89B38
      final factor = (dist / 600.0).clamp(0.0, 1.0);
      final r = (248 - factor * 25).round();
      final g = (145 - factor * 45).round();
      final b = (45 - factor * 15).round();
      featureGraphic.setPixel(x, y, img.ColorRgb8(r, g, b));
    }
  }

  // Draw the centered character + badge scaled to height ~440px
  final featureArtwork = img.copyResize(
    fullSquare,
    width: 440,
    height: 440,
    interpolation: img.Interpolation.cubic,
  );
  // Overlay onto center of feature graphic
  img.compositeImage(featureGraphic, featureArtwork, dstX: (1024 - 440) ~/ 2, dstY: (500 - 440) ~/ 2);
  File('store/playstore_feature_graphic_1024x500.png').writeAsBytesSync(img.encodePng(featureGraphic));
  stdout.writeln('Saved store/playstore_feature_graphic_1024x500.png (1024x500)');

  // 5. Web icons
  final webDir = Directory('web/icons');
  if (webDir.existsSync()) {
    final icon192 = img.copyResize(fullSquare, width: 192, height: 192, interpolation: img.Interpolation.cubic);
    final icon512 = img.copyResize(fullSquare, width: 512, height: 512, interpolation: img.Interpolation.cubic);
    File('web/icons/Icon-192.png').writeAsBytesSync(img.encodePng(icon192));
    File('web/icons/Icon-512.png').writeAsBytesSync(img.encodePng(icon512));
    File('web/icons/Icon-maskable-192.png').writeAsBytesSync(img.encodePng(icon192));
    File('web/icons/Icon-maskable-512.png').writeAsBytesSync(img.encodePng(icon512));
    final favicon = img.copyResize(fullSquare, width: 64, height: 64, interpolation: img.Interpolation.cubic);
    File('web/favicon.png').writeAsBytesSync(img.encodePng(favicon));
    stdout.writeln('Updated web/ icons');
  }

  stdout.writeln('All brand assets successfully generated!');
}
