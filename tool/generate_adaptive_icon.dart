// One-off asset generator, not part of the app build. Run with:
//   dart run tool/generate_adaptive_icon.dart
//
// Produces assets/images/cremen_logo_adaptive_fg.png: the brand logo scaled
// to Android's adaptive-icon safe zone (~66%) and centered on a transparent
// 1024x1024 canvas, so `flutter_launcher_icons`' adaptive_icon_foreground can
// use it without the launcher's circular/squircle mask cropping the logo's
// edge-to-edge brand ring (see the pubspec.yaml comment above
// flutter_launcher_icons: for why the plain image_path alone isn't enough).
import 'dart:io';
import 'package:image/image.dart' as img;

const _canvasSize = 1024;
const _safeZoneScale = 0.66;

void main() {
  final sourceFile = File('assets/images/cremen_logo.jpg');
  final sourceBytes = sourceFile.readAsBytesSync();
  final source = img.decodeImage(sourceBytes);
  if (source == null) {
    stderr.writeln('Could not decode assets/images/cremen_logo.jpg');
    exit(1);
  }

  final targetSize = (_canvasSize * _safeZoneScale).round();
  final resized = img.copyResize(
    source,
    width: targetSize,
    height: targetSize,
    interpolation: img.Interpolation.cubic,
  );

  final canvas = img.Image(
    width: _canvasSize,
    height: _canvasSize,
    numChannels: 4,
  );
  img.fill(canvas, color: img.ColorRgba8(0, 0, 0, 0));

  final offset = ((_canvasSize - targetSize) / 2).round();
  img.compositeImage(canvas, resized, dstX: offset, dstY: offset);

  final outFile = File('assets/images/cremen_logo_adaptive_fg.png');
  outFile.writeAsBytesSync(img.encodePng(canvas));
  stdout.writeln('Wrote ${outFile.path} (${canvas.width}x${canvas.height})');
}
