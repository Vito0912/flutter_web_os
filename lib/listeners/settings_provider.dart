import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_os/models/settings_model.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  return SettingsNotifier();
});

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings());

  void updateSettings(Settings newSettings) {
    state = newSettings;
  }

  void updateDarkMode(bool isDarkMode) {
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  void updateDesktopBackground(String desktopBackground) {
    state = state.copyWith(desktopBackground: desktopBackground);
  }

  void updateAccentColor(AccentColor? accentColor) {
    state = state.copyWith(accentColor: accentColor);
  }
}
