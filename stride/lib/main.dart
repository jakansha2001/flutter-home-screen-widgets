import 'package:flutter/material.dart';

import 'theme.dart';
import 'today_screen.dart';

void main() => runApp(const StrideApp());

class StrideApp extends StatelessWidget {
  const StrideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stride',
      debugShowCheckedModeBanner: false,
      theme: strideTheme(),
      home: const TodayScreen(),
    );
  }
}
