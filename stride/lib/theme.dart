import 'package:flutter/material.dart';

/// Night run: near-black, one lime accent for steps, orange for the streak.
abstract final class StrideColors {
  static const background = Color(0xFF111418);
  static const surface = Color(0xFF1A1E24);
  static const track = Color(0xFF2A2F37);
  static const lime = Color(0xFFC6FF3D);
  static const orange = Color(0xFFFF7A1A);
  static const white = Color(0xFFF5F7FA);
  static const muted = Color(0xFF8A9099);
}

/// Condensed numerals, the way fitness apps show their big numbers.
const numbers = 'BarlowCondensed';

ThemeData strideTheme() {
  final base = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: StrideColors.background,
    colorScheme: const ColorScheme.dark(
      primary: StrideColors.lime,
      onPrimary: StrideColors.background,
      secondary: StrideColors.orange,
      surface: StrideColors.surface,
      onSurface: StrideColors.white,
    ),
  );
  return base.copyWith(
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: StrideColors.track,
        selectedForegroundColor: StrideColors.lime,
        foregroundColor: StrideColors.muted,
        side: const BorderSide(color: StrideColors.track),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        shape: const StadiumBorder(),
        textStyle: const TextStyle(
          fontFamily: numbers,
          fontWeight: FontWeight.w800,
          fontSize: 22,
          letterSpacing: 0.5,
        ),
      ),
    ),
  );
}
