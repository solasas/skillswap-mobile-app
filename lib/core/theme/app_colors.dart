import 'package:flutter/material.dart';

/// Hand-picked palette (not a Material `ColorScheme.fromSeed` tonal ramp) so
/// the app doesn't read as the same indigo/purple every generated Flutter
/// UI ships with. Warm, editorial, community-project tones instead of
/// corporate SaaS blue.
class AppColors {
  AppColors._();

  // Light
  static const lightBackground = Color(0xFFFAF6EE);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceAlt = Color(0xFFF3EDE0);
  static const lightPrimary = Color(0xFF2B6455);
  static const lightPrimaryContainer = Color(0xFFDCEEE6);
  static const lightOnPrimaryContainer = Color(0xFF0E3327);
  static const lightAccent = Color(0xFFCC8A2C);
  static const lightAccentContainer = Color(0xFFF6E6C9);
  static const lightDanger = Color(0xFFB8453D);
  static const lightDangerContainer = Color(0xFFF6DEDB);
  static const lightOutline = Color(0xFFE1D9C7);
  static const lightOnSurface = Color(0xFF1F241F);
  static const lightOnSurfaceMuted = Color(0xFF6D6656);

  // Dark
  static const darkBackground = Color(0xFF14181A);
  static const darkSurface = Color(0xFF1B2120);
  static const darkSurfaceAlt = Color(0xFF232A28);
  static const darkPrimary = Color(0xFF7FC4AA);
  static const darkPrimaryContainer = Color(0xFF204439);
  static const darkOnPrimaryContainer = Color(0xFFCBEBDD);
  static const darkAccent = Color(0xFFE7AD52);
  static const darkAccentContainer = Color(0xFF473313);
  static const darkDanger = Color(0xFFE0857D);
  static const darkDangerContainer = Color(0xFF4A2321);
  static const darkOutline = Color(0xFF34403A);
  static const darkOnSurface = Color(0xFFEAEEE8);
  static const darkOnSurfaceMuted = Color(0xFF9CA79E);

  // Semantic (identical in both modes; used for status pills)
  static const pending = Color(0xFFCC8A2C);
  static const accepted = Color(0xFF2B6455);
  static const rejected = Color(0xFFB8453D);
  static const completed = Color(0xFF3D6BA6);
  static const star = Color(0xFFDB9B2C);
}
