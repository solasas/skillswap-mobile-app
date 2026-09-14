// Enums that are transmitted as plain strings on the wire by the Spring
// Boot backend. Kept as simple Dart enums with manual (de)serialization
// helpers so unrecognized values from the server never crash the app.

enum SkillCategory { music, tech, cooking, language, fitness, art, other }

enum SkillLevel { beginner, intermediate, advanced }

enum SkillType { teach, learn }

enum ExchangeStatus { pending, accepted, rejected, completed }

enum SessionMode { online, offline }

enum SessionStatus { scheduled, completed, cancelled }

extension SkillCategoryX on SkillCategory {
  String get wire => name.toUpperCase();

  String get label {
    switch (this) {
      case SkillCategory.music:
        return 'Music';
      case SkillCategory.tech:
        return 'Tech';
      case SkillCategory.cooking:
        return 'Cooking';
      case SkillCategory.language:
        return 'Language';
      case SkillCategory.fitness:
        return 'Fitness';
      case SkillCategory.art:
        return 'Art';
      case SkillCategory.other:
        return 'Other';
    }
  }

  static SkillCategory fromWire(String? value) {
    return SkillCategory.values.firstWhere(
      (e) => e.wire == value,
      orElse: () => SkillCategory.other,
    );
  }
}

extension SkillLevelX on SkillLevel {
  String get wire => name.toUpperCase();

  String get label {
    switch (this) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
    }
  }

  static SkillLevel fromWire(String? value) {
    return SkillLevel.values.firstWhere(
      (e) => e.wire == value,
      orElse: () => SkillLevel.beginner,
    );
  }
}

extension SkillTypeX on SkillType {
  String get wire => name.toUpperCase();

  String get label => this == SkillType.teach ? 'Teach' : 'Learn';

  static SkillType fromWire(String? value) {
    return SkillType.values.firstWhere(
      (e) => e.wire == value,
      orElse: () => SkillType.teach,
    );
  }
}

extension ExchangeStatusX on ExchangeStatus {
  String get wire => name.toUpperCase();

  String get label {
    switch (this) {
      case ExchangeStatus.pending:
        return 'Pending';
      case ExchangeStatus.accepted:
        return 'Accepted';
      case ExchangeStatus.rejected:
        return 'Rejected';
      case ExchangeStatus.completed:
        return 'Completed';
    }
  }

  static ExchangeStatus fromWire(String? value) {
    return ExchangeStatus.values.firstWhere(
      (e) => e.wire == value,
      orElse: () => ExchangeStatus.pending,
    );
  }
}

extension SessionModeX on SessionMode {
  String get wire => name.toUpperCase();

  String get label => this == SessionMode.online ? 'Online' : 'Offline';

  static SessionMode fromWire(String? value) {
    return SessionMode.values.firstWhere(
      (e) => e.wire == value,
      orElse: () => SessionMode.online,
    );
  }
}

// Top-level (de)serialization functions for use with @JsonKey(fromJson/toJson)
// on freezed model fields.

SkillCategory skillCategoryFromJson(String? json) => SkillCategoryX.fromWire(json);
String skillCategoryToJson(SkillCategory value) => value.wire;

SkillLevel skillLevelFromJson(String? json) => SkillLevelX.fromWire(json);
String skillLevelToJson(SkillLevel value) => value.wire;

SkillType skillTypeFromJson(String? json) => SkillTypeX.fromWire(json);
String skillTypeToJson(SkillType value) => value.wire;

ExchangeStatus exchangeStatusFromJson(String? json) => ExchangeStatusX.fromWire(json);
String exchangeStatusToJson(ExchangeStatus value) => value.wire;

SessionMode sessionModeFromJson(String? json) => SessionModeX.fromWire(json);
String sessionModeToJson(SessionMode value) => value.wire;

SessionStatus sessionStatusFromJson(String? json) => SessionStatusX.fromWire(json);
String sessionStatusToJson(SessionStatus value) => value.wire;

extension SessionStatusX on SessionStatus {
  String get wire => name.toUpperCase();

  String get label {
    switch (this) {
      case SessionStatus.scheduled:
        return 'Scheduled';
      case SessionStatus.completed:
        return 'Completed';
      case SessionStatus.cancelled:
        return 'Cancelled';
    }
  }

  static SessionStatus fromWire(String? value) {
    return SessionStatus.values.firstWhere(
      (e) => e.wire == value,
      orElse: () => SessionStatus.scheduled,
    );
  }
}
