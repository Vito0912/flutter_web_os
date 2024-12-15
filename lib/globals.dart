import 'package:flutter/material.dart';
import 'package:flutter_web_os/models/AppItem.dart';

List<AppItem> appItems = [];

List<AppItem> desktopItems = [
  AppItem(
    name: 'Settings',
    icon: Icons.settings,
    applet: 'settings',
  ),
  AppItem(
    name: 'Counter',
    icon: Icons.add,
    applet: 'counter',
  ),
  AppItem(
    name: 'Explorer',
    icon: Icons.folder,
    applet: 'explorer',
  ),
  AppItem(
    name: 'Video',
    icon: Icons.video_library,
    applet: 'video_player',
  )
];
