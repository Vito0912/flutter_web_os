import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_web_os/applets/counter.dart';
import 'package:flutter_web_os/applets/explorer.dart';
import 'package:flutter_web_os/applets/settings.dart';
import 'package:flutter_web_os/applets/video_player.dart';

Map<String, Widget> availableApplets = {
  'counter': const Counter(),
  'settings': const Settings(),
  'explorer': const Explorer(),
  'video_player': const VideoPlayerView(),
};
