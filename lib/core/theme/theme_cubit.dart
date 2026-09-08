import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

/// Persists the user's light/dark/system choice so it survives app restarts.
/// [boxName] must already be open (via [Hive.openBox]) before this is constructed —
/// wired in `main.dart`, before `configureDependencies()`/`runApp()`.
@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(_readStored());

  static const boxName = 'settings_box';
  static const _themeKey = 'themeMode';

  static ThemeMode _readStored() {
    final box = Hive.box(boxName);
    return switch (box.get(_themeKey) as String?) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  Future<void> changeTheme(ThemeMode mode) async {
    emit(mode);
    await Hive.box(boxName).put(_themeKey, mode.name);
  }
}
