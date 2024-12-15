import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_web_os/applets/counter.dart';
import 'package:flutter_web_os/applets/settings.dart';

Map<String, Widget> availableApplets = {
  'counter': const Counter(),
  'settings': const Settings()
};
