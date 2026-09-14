import 'package:flutter/material.dart';

/// Small uppercase, letter-spaced label used above list sections — reads
/// more like an edited product than a plain bold `Text` header.
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text.toUpperCase(), style: style),
        if (trailing != null) trailing!,
      ],
    );
  }
}
