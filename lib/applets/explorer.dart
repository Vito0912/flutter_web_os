import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  List<String> filesystem = [];

  @override
  void initState() {
    (rootBundle.loadString('AssetManifest.json')).then((manifestContent) {
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final Map<String, dynamic> filesystemMap = Map.fromEntries(manifestMap
          .entries
          .where((entry) => entry.key.contains('assets/filesystem/')));

      setState(() {
        filesystem = filesystemMap.keys.toList();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (filesystem.isEmpty) {
      return const Center(
        child: ProgressRing(),
      );
    }
    return ListView.builder(
      itemCount: filesystem.length,
      itemBuilder: (context, index) {
        final String filename = filesystem[index];
        return ListTile(
          title: Text(filename),
        );
      },
    );
  }
}
