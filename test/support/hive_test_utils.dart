import 'dart:io';
import 'package:cremen_eatstreet_shop_application/core/services/hive_storage_service.dart';

/// Points Hive at a fresh temp directory unique to this test file, so that
/// `flutter test` running multiple files concurrently never fight over the
/// same on-disk lock file (which surfaces as a flaky `PathAccessException`).
Future<void> initIsolatedHive() async {
  final dir = Directory.systemTemp.createTempSync('cremen_hive_test_');
  await HiveStorageService.init(storagePath: dir.path);
}
