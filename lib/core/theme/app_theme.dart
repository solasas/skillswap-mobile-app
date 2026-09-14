import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static TextTheme _textTheme(Color base) {
    final headingFont = TextStyle(fontFamily: 'Sora', color: base);
    final bodyFont = TextStyle(fontFamily: 'Manrope', color: base);
    return TextTheme(
      displaySmall: headingFont.copyWith(fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -0.5),
      headlineSmall: headingFont.copyWith(fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: -0.3),
      titleLarge: headingFont.copyWith(fontSize: 21, fontWeight: FontWeight.w700, letterSpacing: -0.2),
      titleMedium: headingFont.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      titleSmall: bodyFont.copyWith(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
      bodyLarge: bodyFont.copyWith(fontSize: 16, fontWeight: FontWeight.w500, height: 1.4),
      bodyMedium: bodyFont.copyWith(fontSize: 14, fontWeight: FontWeight.w500, height: 1.4),
      bodySmall: bodyFont.copyWith(fontSize: 12.5, fontWeight: FontWeight.w600),
      labelLarge: bodyFont.copyWith(fontSize: 14.5, fontWeight: FontWeight.w700, letterSpacing: 0.2),
    );
  }

  static ThemeData light() {
    const scheme = ColorScheme.light(
      brightness: Brightness.light,
      primary: AppColors.lightPrimary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.lightPrimaryContainer,
      onPrimaryContainer: AppColors.lightOnPrimaryContainer,
      secondary: AppColors.lightAccent,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.lightAccentContainer,
      onSecondaryContainer: Color(0xFF4A3305),
      error: AppColors.lightDanger,
      onError: Colors.white,
      errorContainer: AppColors.lightDangerContainer,
      onErrorContainer: Color(0xFF4A140F),
      surface: AppColors.lightSurface,
      onSurface: AppColors.lightOnSurface,
      surfaceContainerHighest: AppColors.lightSurfaceAlt,
      onSurfaceVariant: AppColors.lightOnSurfaceMuted,
      outline: AppColors.lightOutline,
      outlineVariant: Color(0xFFEDE7D9),
    );

    return _build(scheme, AppColors.lightBackground, AppColors.lightOnSurface, AppColors.lightOnSurfaceMuted);
  }

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      brightness: Brightness.dark,
      primary: AppColors.darkPrimary,
      onPrimary: Color(0xFF06231A),
      primaryContainer: AppColors.darkPrimaryContainer,
      onPrimaryContainer: AppColors.darkOnPrimaryContainer,
      secondary: AppColors.darkAccent,
      onSecondary: Color(0xFF2C1D00),
      secondaryContainer: AppColors.darkAccentContainer,
      onSecondaryContainer: Color(0xFFFBDFAF),
      error: AppColors.darkDanger,
      onError: Color(0xFF2C0906),
      errorContainer: AppColors.darkDangerContainer,
      onErrorContainer: Color(0xFFFAD5D0),
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkOnSurface,
      surfaceContainerHighest: AppColors.darkSurfaceAlt,
      onSurfaceVariant: AppColors.darkOnSurfaceMuted,
      outline: AppColors.darkOutline,
      outlineVariant: Color(0xFF2A322E),
    );

    return _build(scheme, AppColors.darkBackground, AppColors.darkOnSurface, AppColors.darkOnSurfaceMuted);
  }

  static ThemeData _build(ColorScheme scheme, Color background, Color onSurface, Color onSurfaceMuted) {
    final textTheme = _textTheme(onSurface);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        foregroundColor: onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        toolbarHeight: 64,
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, thickness: 1, space: 32),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.error),
        ),
        labelStyle: TextStyle(color: onSurfaceMuted, fontWeight: FontWeight.w600),
        hintStyle: TextStyle(color: onSurfaceMuted),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest,
        side: BorderSide(color: scheme.outlineVariant),
        labelStyle: textTheme.bodySmall,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: const StadiumBorder(),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: scheme.outline, width: 1.4),
          textStyle: textTheme.labelLarge,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          selectedBackgroundColor: scheme.primaryContainer,
          selectedForegroundColor: scheme.onPrimaryContainer,
          side: BorderSide(color: scheme.outline),
          textStyle: textTheme.bodyMedium,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: onSurfaceMuted,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.titleSmall,
        indicatorColor: scheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: scheme.outlineVariant,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: scheme.primaryContainer,
        elevation: 0,
        height: 68,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.bodySmall?.copyWith(
            color: selected ? scheme.primary : onSurfaceMuted,
            fontWeight: FontWeight.w700,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(color: selected ? scheme.onPrimaryContainer : onSurfaceMuted);
        }),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: onSurfaceMuted,
        titleTextStyle: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        subtitleTextStyle: textTheme.bodySmall,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.onSurface,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: background),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
