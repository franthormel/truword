import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'theme.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = buildTheme();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Homepage(),
    );
  }
}
