import 'package:flutter/material.dart';

/// The app's wordmark badge: a rounded square lettermark rendered from the
/// brand typeface rather than a generic Material icon, so the app doesn't
/// read as visually interchangeable with any other scaffolded Flutter app.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primary, Color.lerp(scheme.primary, Colors.black, 0.28)!],
        ),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: size * 0.14,
            bottom: size * 0.14,
            child: Container(
              width: size * 0.16,
              height: size * 0.16,
              decoration: BoxDecoration(color: scheme.secondary, shape: BoxShape.circle),
            ),
          ),
          Text(
            'sw',
            style: TextStyle(
              fontFamily: 'Sora',
              color: scheme.onPrimary,
              fontSize: size * 0.42,
              fontWeight: FontWeight.w800,
              height: 1,
              letterSpacing: -1,
            ),
          ),
        ],
      ),
    );
  }
}
