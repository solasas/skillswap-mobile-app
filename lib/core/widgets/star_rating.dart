import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Read-only star display.
class StarRatingDisplay extends StatelessWidget {
  const StarRatingDisplay({super.key, required this.stars, this.size = 18});

  final double stars;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < stars.round();
        return Icon(
          filled ? Icons.star : Icons.star_border,
          size: size,
          color: AppColors.star,
        );
      }),
    );
  }
}

/// Interactive 1-5 star picker used on the rate-session screen.
class StarRatingInput extends StatelessWidget {
  const StarRatingInput({super.key, required this.value, required this.onChanged});

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final starIndex = i + 1;
        return IconButton(
          onPressed: () => onChanged(starIndex),
          icon: Icon(
            starIndex <= value ? Icons.star : Icons.star_border,
            color: AppColors.star,
            size: 34,
          ),
        );
      }),
    );
  }
}
