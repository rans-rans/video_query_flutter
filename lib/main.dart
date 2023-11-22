import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

const methodChannel = MethodChannel("method_channel");

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
