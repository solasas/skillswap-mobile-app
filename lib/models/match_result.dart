import 'skill.dart';
import 'user.dart';

/// The exact JSON shape of `/matches` responses isn't specified in the API
/// docs handed to the client, so this parses defensively: it tries several
/// plausible field-name variants for the matched user and the overlapping
/// skill lists, and falls back to empty/false rather than throwing. If the
/// real backend response uses different keys, adjust the `_firstOf` lookups
/// below — the rest of the app only depends on this class's fields.
class MatchResult {
  final User user;
  final List<Skill> skillsTheyCanTeachYou;
  final List<Skill> skillsYouCanTeachThem;
  final bool isMutual;

  MatchResult({
    required this.user,
    required this.skillsTheyCanTeachYou,
    required this.skillsYouCanTeachThem,
    required this.isMutual,
  });

  factory MatchResult.fromJson(Map<String, dynamic> json) {
    final userJson = _firstOf(json, ['user', 'matchedUser', 'matchUser']);
    final teachJson = _firstOf(json, [
      'skillsTheyCanTeachYou',
      'theyTeach',
      'canTeachYou',
      'matchingTeachSkills',
      'offeredSkills',
    ]);
    final learnJson = _firstOf(json, [
      'skillsYouCanTeachThem',
      'theyWantToLearn',
      'canLearnFromYou',
      'matchingLearnSkills',
      'wantedSkills',
    ]);
    final mutual = _firstOf(json, ['mutual', 'isMutual']);

    return MatchResult(
      user: userJson is Map<String, dynamic>
          ? User.fromJson(userJson)
          : User.fromJson(json),
      skillsTheyCanTeachYou: _parseSkillList(teachJson),
      skillsYouCanTeachThem: _parseSkillList(learnJson),
      isMutual: mutual is bool ? mutual : false,
    );
  }

  static dynamic _firstOf(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      if (json.containsKey(key)) return json[key];
    }
    return null;
  }

  static List<Skill> _parseSkillList(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .whereType<Map<String, dynamic>>()
        .map(Skill.fromJson)
        .toList();
  }
}
