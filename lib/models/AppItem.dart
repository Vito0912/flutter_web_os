import 'package:fluent_ui/fluent_ui.dart';

class AppItem {
  final String? id;
  final String name;
  final IconData icon;
  final String applet;
  final bool isVisible;

  AppItem(
      {this.id,
      required this.name,
      required this.icon,
      required this.applet,
      this.isVisible = true});

  // CopyWith
  AppItem copyWith({
    String? id,
    String? name,
    IconData? icon,
    String? applet,
    bool? isVisible,
  }) {
    return AppItem(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      applet: applet ?? this.applet,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  // Clone
  AppItem clone() {
    return AppItem(
      id: id,
      name: name,
      icon: icon,
      applet: applet,
      isVisible: isVisible,
    );
  }
}
