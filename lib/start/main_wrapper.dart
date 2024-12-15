import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_web_os/start/desktop.dart';
import 'package:flutter_web_os/start/task_bar.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [Desktop(), TaskBar()],
    );
  }
}
