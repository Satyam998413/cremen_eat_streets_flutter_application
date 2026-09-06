import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:flutter/material.dart';

/// Platform-adaptive light/dark/system selector — a Cupertino sliding segmented
/// control on iOS/macOS, a Material [SegmentedButton] everywhere else.
class ThemeModeSwitch extends StatelessWidget {
  const ThemeModeSwitch({super.key, required this.value, required this.onChanged});

  final ThemeMode value;
  final ValueChanged<ThemeMode> onChanged;

  static const _labels = {
    ThemeMode.light: 'Light',
    ThemeMode.system: 'Auto',
    ThemeMode.dark: 'Dark',
  };

  @override
  Widget build(BuildContext context) {
    final isCupertino = defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;

    if (isCupertino) {
      return CupertinoSlidingSegmentedControl<ThemeMode>(
        groupValue: value,
        children: _labels.map(
          (mode, label) => MapEntry(
            mode,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(label),
            ),
          ),
        ),
        onValueChanged: (mode) {
          if (mode != null) onChanged(mode);
        },
      );
    }

    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(
          value: ThemeMode.light,
          icon: Icon(Icons.light_mode_outlined),
          label: Text('Light'),
        ),
        ButtonSegment(
          value: ThemeMode.system,
          icon: Icon(Icons.brightness_auto_outlined),
          label: Text('Auto'),
        ),
        ButtonSegment(
          value: ThemeMode.dark,
          icon: Icon(Icons.dark_mode_outlined),
          label: Text('Dark'),
        ),
      ],
      selected: {value},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
