import 'package:flutter/material.dart';

import '../utils/enums.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge.exchange(this.status, {super.key})
      : label = null,
        _kind = _Kind.exchange;

  const StatusBadge.session(this.status, {super.key})
      : label = null,
        _kind = _Kind.session;

  final Object? status;
  final String? label;
  final _Kind _kind;

  @override
  Widget build(BuildContext context) {
    final (text, color) = switch (_kind) {
      _Kind.exchange => _exchangeStyle(status as ExchangeStatus),
      _Kind.session => _sessionStyle(status as SessionStatus),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  (String, Color) _exchangeStyle(ExchangeStatus status) {
    switch (status) {
      case ExchangeStatus.pending:
        return ('Pending', Colors.orange);
      case ExchangeStatus.accepted:
        return ('Accepted', Colors.green);
      case ExchangeStatus.rejected:
        return ('Rejected', Colors.red);
      case ExchangeStatus.completed:
        return ('Completed', Colors.blue);
    }
  }

  (String, Color) _sessionStyle(SessionStatus status) {
    switch (status) {
      case SessionStatus.scheduled:
        return ('Scheduled', Colors.blue);
      case SessionStatus.completed:
        return ('Completed', Colors.green);
      case SessionStatus.cancelled:
        return ('Cancelled', Colors.red);
    }
  }
}

enum _Kind { exchange, session }
