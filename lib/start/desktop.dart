import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_os/globals.dart';
import 'package:flutter_web_os/listeners/settings_provider.dart';
import 'package:flutter_web_os/listeners/windows.dart';

class Desktop extends ConsumerWidget {
  const Desktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Image.asset(
          ref.watch(settingsProvider).desktopBackground,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.maxWidth ~/ 100,
                crossAxisSpacing: 8.0,
                childAspectRatio: 1.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: desktopItems.length,
              itemBuilder: (context, index) {
                final item = desktopItems[index];
                return Material(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Consumer(builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return InkWell(
                        onTap: () {
                          ref
                              .read(appItemListProvider.notifier)
                              .addAppItem(item.clone());
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Icon(
                                item.icon,
                                size: 48,
                              ),
                              const Spacer(),
                              Text(item.name),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              });
        }),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final allWindows = ref.watch(allWindowsProvider);
            return Stack(
              children: allWindows,
            );
          },
        )
      ],
    );
  }
}
