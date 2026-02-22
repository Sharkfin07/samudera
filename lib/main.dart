import 'package:flutter/material.dart';

import './core/config/env_config.dart';

Future<void> main() async {
  await EnvConfig.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('Hello World!'))),
    );
  }
}
