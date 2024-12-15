import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_os/listeners/settings_provider.dart';
import 'package:flutter_web_os/start/main_wrapper.dart';
import 'package:system_theme/system_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(builder: (context, ref, child) {
        return FluentApp(
          title: 'Vito OS',
          theme: FluentThemeData(
            accentColor: ref.watch(settingsProvider).accentColor ??
                SystemTheme.accentColor.accent.toAccentColor(),
            brightness: ref.watch(settingsProvider).isDarkMode
                ? Brightness.dark
                : Brightness.light,
          ),
          home: const MainWrapper(),
        );
      }),
    );
  }
}
