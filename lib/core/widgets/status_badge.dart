import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../utils/enums.dart';

/// Small dot-and-label chip. Deliberately not a filled pill in a primary
/// hue — a quiet dot keeps status secondary to the content around it.
class StatusBadge extends StatelessWidget {
  const StatusBadge.exchange(this.status, {super.key})
      : _kind = _Kind.exchange;

  const StatusBadge.session(this.status, {super.key})
      : _kind = _Kind.session;

  final Object status;
  final _Kind _kind;

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (_kind) {
      _Kind.exchange => _exchangeStyle(status as ExchangeStatus),
      _Kind.session => _sessionStyle(status as SessionStatus),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color, letterSpacing: 0.2),
        ),
      ],
    );
  }

  (String, Color) _exchangeStyle(ExchangeStatus status) {
    switch (status) {
      case ExchangeStatus.pending:
        return ('Pending', AppColors.pending);
      case ExchangeStatus.accepted:
        return ('Accepted', AppColors.accepted);
      case ExchangeStatus.rejected:
        return ('Rejected', AppColors.rejected);
      case ExchangeStatus.completed:
        return ('Completed', AppColors.completed);
    }
  }

  (String, Color) _sessionStyle(SessionStatus status) {
    switch (status) {
      case SessionStatus.scheduled:
        return ('Scheduled', AppColors.completed);
      case SessionStatus.completed:
        return ('Completed', AppColors.accepted);
      case SessionStatus.cancelled:
        return ('Cancelled', AppColors.rejected);
    }
  }
}

enum _Kind { exchange, session }
