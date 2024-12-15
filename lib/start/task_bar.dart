import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_os/globals.dart' show appItems;
import 'package:flutter_web_os/listeners/windows.dart';

class TaskBar extends StatelessWidget {
  const TaskBar({super.key});

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
            clipBehavior: Clip.none,
            child: Stack(
              children: [
                const Divider(
                  style: DividerThemeData(
                      thickness: 1, horizontalMargin: EdgeInsets.zero),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 4, bottom: 4, left: 2, right: 2),
                  child: SizedBox(
                    height: 42,
                    child: Row(
                      children: [
                        Expanded(
                          child: Consumer(builder: (BuildContext context,
                              WidgetRef ref, Widget? child) {
                            final items = [
                              ...appItems,
                              ...ref.watch(appItemListProvider)
                            ];
                            return ReorderableListView.builder(
                              scrollDirection: Axis.horizontal,
                              buildDefaultDragHandles: false,
                              onReorder: (int oldIndex, int newIndex) {
                                print('Reordered: $oldIndex -> $newIndex');
                              },
                              dragStartBehavior: DragStartBehavior.down,
                              itemBuilder: (BuildContext context, int index) {
                                final item = items[index];
                                return ReorderableDragStartListener(
                                  key: ValueKey<String>(
                                      item.name + index.toString()),
                                  index: index,
                                  child: FluentTheme(
                                    data: theme,
                                    child: IconButton(
                                      icon: Column(children: [
                                        Icon(item.icon, size: 28),
                                        if (ref
                                            .read(appItemListProvider.notifier)
                                            .getAppItemById(item.id!)!
                                            .isVisible) ...[
                                          const SizedBox(height: 4),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                                height: 3,
                                                width: 12,
                                                color: theme.accentColor,
                                                child: const SizedBox()),
                                          )
                                        ]
                                      ]),
                                      style: ButtonStyle(
                                        padding: WidgetStateProperty.all(
                                            const EdgeInsets.all(4)),
                                      ),
                                      onPressed: () {
                                        if (item.id != null) {
                                          ref
                                              .read(
                                                  appItemListProvider.notifier)
                                              .updateAppItemVisibility(
                                                  item.id!,
                                                  !ref
                                                      .read(appItemListProvider
                                                          .notifier)
                                                      .getAppItemById(item.id!)!
                                                      .isVisible);
                                        } else {
                                          throw Exception(
                                              'AppItem ID is required.');
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                              itemCount: items.length,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
