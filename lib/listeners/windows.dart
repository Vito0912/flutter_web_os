import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_os/applets.dart';
import 'package:flutter_web_os/models/AppItem.dart';
import 'package:flutter_web_os/util/moveable_widget.dart';
import 'package:uuid/uuid.dart';

class AppItemListNotifier extends StateNotifier<List<AppItem>> {
  AppItemListNotifier() : super([]); // Initial state is an empty list.

  void addAppItem(AppItem item) {
    final uuid = const Uuid().v4();
    if (state.length < 1) {
      state = [...state, item.copyWith(id: uuid, isVisible: true)];
    }
  }

  void deleteAppItemById(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void reorderAppItems(int oldIndex, int newIndex) {
    if (oldIndex < 0 ||
        oldIndex >= state.length ||
        newIndex < 0 ||
        newIndex >= state.length) {
      return; // Prevent invalid reorder operations.
    }

    final updatedList = List.of(state);
    final item = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, item);

    state = updatedList;
  }

  void updateAppItemVisibility(String id, bool isVisible) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(isVisible: isVisible).clone();
      }
      return item.clone();
    }).toList();
  }

  void updateAppItemById(String id, AppItem newItem) {
    state = state.map((item) {
      if (item.id == id) {
        return newItem;
      }
      return item;
    }).toList();
  }

  AppItem? getAppItemByName1(String name) {
    return state.where((item) => item.name == name).firstOrNull;
  }

  AppItem? getAppItemById(String id) {
    return state.where((item) => item.id == id).firstOrNull;
  }
}

final appItemListProvider =
    StateNotifierProvider<AppItemListNotifier, List<AppItem>>((ref) {
  return AppItemListNotifier();
});

final windowProvider = Provider.family<Widget, AppItem>((ref, item) {
  if (item.id == null) {
    throw Exception('AppItem ID is required.');
  }

  return MoveableWidget(
    key: ValueKey(item.id),
    title: item.name,
    content: availableApplets[item.applet],
    appItem: item,
  );
});

final allWindowsProvider = Provider<List<Widget>>((ref) {
  final appItemList = ref.watch(appItemListProvider);

  return appItemList.map((item) {
    print(item.id);
    print(item.isVisible);
    return ref.watch(windowProvider(item)); // Always return all windows
  }).toList();
});
