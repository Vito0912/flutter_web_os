import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' show Icons, Scaffold;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_os/listeners/windows.dart';
import 'package:flutter_web_os/models/AppItem.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MoveableWidget extends HookConsumerWidget {
  final Offset initialPosition;
  final Size initialSize;
  final String title;
  final Widget? content;
  final AppItem appItem;

  MoveableWidget(
      {super.key,
      required this.title,
      required this.appItem,
      this.content,
      this.initialPosition = Offset.zero,
      this.initialSize = const Size(300, 200)});

  Size previousSize = const Size(0, 0);
  Offset previousPosition = const Offset(0, 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HookBuilder(builder: (context) {
      final FluentThemeData theme = FluentTheme.of(context);
      final position = useState(initialPosition);
      final size = useState(initialSize);
      final maximized = useState(false);

      maximize() {
        if (maximized.value) {
          size.value = previousSize;
          position.value = previousPosition;
          maximized.value = false;
        } else {
          final deviceSize = MediaQuery.of(context).size;
          previousSize = size.value;
          previousPosition = position.value;
          position.value = Offset.zero;
          size.value = deviceSize;
          maximized.value = true;
        }
      }

      return Positioned(
        key: ValueKey('visible${appItem.id}'),
        left: position.value.dx,
        top: position.value.dy,
        child: Offstage(
          offstage: !appItem.isVisible,
          child: FluentTheme(
            data: theme,
            child: NotificationListener(
              onNotification: (notification) {
                if (maximized.value) {
                  size.value = MediaQuery.of(context).size;
                }
                return true;
              },
              child: SizedBox(
                width: size.value.width,
                height: size.value.height,
                child: Column(
                  children: [
                    GestureDetector(
                      onPanUpdate: (details) {
                        if (details.globalPosition.dx < 5 ||
                            details.globalPosition.dy < 5) {
                          return;
                        }

                        final deviceSize = MediaQuery.of(context).size;
                        if (details.globalPosition.dx > deviceSize.width ||
                            details.globalPosition.dy >
                                deviceSize.height - 60) {
                          return;
                        }

                        position.value = Offset(
                            position.value.dx + details.delta.dx,
                            position.value.dy + details.delta.dy);
                      },
                      //onDoubleTap: () => maximize(),
                      child: Container(
                        color: theme.acrylicBackgroundColor,
                        height: 32,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(title),
                            Consumer(builder: (context, ref, child) {
                              return Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.minimize),
                                    onPressed: () {
                                      ref
                                          .read(appItemListProvider.notifier)
                                          .updateAppItemVisibility(
                                              appItem.id!, false);
                                      print('Hiding ${appItem.id}');
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(maximized.value
                                        ? FluentIcons.mini_contract
                                        : FluentIcons.mini_expand),
                                    onPressed: () => maximize(),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      if (appItem.id != null) {
                                        ref
                                            .read(appItemListProvider.notifier)
                                            .deleteAppItemById(appItem.id!);
                                      } else {
                                        // TODO: Show error window
                                        throw Exception('AppItem ID is null');
                                      }
                                    },
                                  ),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Acrylic(
                            child: Container(
                              // Use all available space
                              constraints: const BoxConstraints.expand(),
                              child: content ??
                                  const Center(
                                    child: Text('Placeholder'),
                                  ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                Size newSize = Size(
                                  size.value.width + details.delta.dx,
                                  size.value.height + details.delta.dy,
                                );
                                if (newSize.width > 200 &&
                                    newSize.height > 200) {
                                  size.value = newSize;
                                }
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.resizeDownRight,
                                child: Container(
                                  color: Colors.transparent,
                                  width: 16,
                                  height: 16,
                                  child: const Icon(
                                    FluentIcons.more,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
