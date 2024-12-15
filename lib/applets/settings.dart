import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_os/listeners/settings_provider.dart';
import 'package:system_theme/system_theme.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dark Mode'),
                  ToggleSwitch(
                      checked: settings.isDarkMode,
                      onChanged:
                          ref.read(settingsProvider.notifier).updateDarkMode),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Accent Color'),
                  SplitButton(
                    flyout: FlyoutContent(
                      constraints: const BoxConstraints(maxWidth: 300.0),
                      child: Wrap(
                        runSpacing: 10.0,
                        spacing: 8.0,
                        children: [
                          ...Colors.accentColors,
                          SystemTheme.accentColor.accent.toAccentColor()
                        ].map((color) {
                          return Button(
                            style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(4.0),
                              ),
                            ),
                            onPressed: () {
                              ref
                                  .read(settingsProvider.notifier)
                                  .updateAccentColor(color);
                              Navigator.of(context).pop(color);
                            },
                            child: Container(
                              height: 32,
                              width: 32,
                              color: color,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: settings.accentColor ??
                            SystemTheme.accentColor.accent.toAccentColor(),
                        borderRadius: const BorderRadiusDirectional.horizontal(
                          start: Radius.circular(4.0),
                        ),
                      ),
                      height: 32,
                      width: 36,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Wallpaper'),
                  SplitButton(
                    flyout: FlyoutContent(
                      constraints: const BoxConstraints(maxWidth: 300.0),
                      child: Wrap(
                        runSpacing: 10.0,
                        spacing: 8.0,
                        children: [
                          'assets/wallpapers/wallpaper.jpg',
                          'assets/wallpapers/wallpaper2.jpg',
                          'assets/wallpapers/wallpaper3.jpg',
                          'assets/wallpapers/wallpaper4.jpg',
                          'assets/wallpapers/wallpaper5.jpg',
                        ].map((assetPath) {
                          return Button(
                            style: const ButtonStyle(
                              padding: WidgetStatePropertyAll(
                                EdgeInsets.all(4.0),
                              ),
                            ),
                            onPressed: () {
                              ref
                                  .read(settingsProvider.notifier)
                                  .updateDesktopBackground(assetPath);
                              Navigator.of(context).pop(assetPath);
                            },
                            child:
                                Image.asset(assetPath, width: 125, height: 125),
                          );
                        }).toList(),
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.horizontal(
                          start: Radius.circular(4.0),
                        ),
                      ),
                      height: 32,
                      width: 36,
                      child: Image.asset(
                        fit: BoxFit.cover,
                        settings.desktopBackground,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
