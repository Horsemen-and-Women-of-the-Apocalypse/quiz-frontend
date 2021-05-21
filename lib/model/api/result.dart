class LobbyResults {
  static const MAXSCORE = 'maxScore';
  static const SCOREBYPLAYERNAME = 'scoreByPlayerName';

  final int maxScore;
  final List<PlayerScore> scoreByPlayerName;

  LobbyResults._(this.maxScore, this.scoreByPlayerName);

  factory LobbyResults.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(MAXSCORE) ||
        !json.containsKey(SCOREBYPLAYERNAME) ||
        !(json[MAXSCORE] is int) ||
        !(json[SCOREBYPLAYERNAME] is List<dynamic>)) {
      throw Exception('Malformed lobby results');
    }

    return LobbyResults._(
        json[MAXSCORE],
        (json[SCOREBYPLAYERNAME] as List<dynamic>)
            .map((e) => PlayerScore.fromJSON(e))
            .toList());
  }
}

/// Player score
class PlayerScore {
  static const String NAME_FIELD_NAME = 'name';
  static const String SCORE_FIELD_NAME = 'score';

  final String name;
  final int score;

  /// Constructor
  PlayerScore(String name, int score)
      : name = name,
        score = score;

  factory PlayerScore.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(NAME_FIELD_NAME) ||
        !json.containsKey(SCORE_FIELD_NAME) ||
        !(json[NAME_FIELD_NAME] is String) ||
        !(json[SCORE_FIELD_NAME] is int)) {
      throw Exception('Malformed PlayerScore');
    }

    return PlayerScore(json[NAME_FIELD_NAME], json[SCORE_FIELD_NAME]);
  }
}
