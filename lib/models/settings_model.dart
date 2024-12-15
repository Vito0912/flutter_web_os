import 'package:fluent_ui/fluent_ui.dart';

class Settings {
  final bool isDarkMode;
  final String desktopBackground;
  final AccentColor? accentColor;

  Settings({bool? isDarkMode, String? desktopBackground, this.accentColor})
      : isDarkMode = isDarkMode ?? true,
        desktopBackground =
            desktopBackground ?? 'assets/wallpapers/wallpaper.jpg';

  Settings copyWith(
      {bool? isDarkMode, String? desktopBackground, AccentColor? accentColor}) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      desktopBackground: desktopBackground ?? this.desktopBackground,
      accentColor: accentColor ?? this.accentColor,
    );
  }
}
