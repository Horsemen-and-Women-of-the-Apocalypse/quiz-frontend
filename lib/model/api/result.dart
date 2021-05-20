class LobbyResults {
  static const MAXSCORE = 'maxScore';
  static const SCOREBYPLAYERNAME = 'scoreByPlayerName';

  String _maxScore;
  Map<String, String> scoreByPlayerName;

  LobbyResults._(this._maxScore, this.scoreByPlayerName);

  String getMaxScore() {
    return _maxScore;
  }

  factory LobbyResults.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(MAXSCORE) ||
        !json.containsKey(SCOREBYPLAYERNAME) ||
        !(json[MAXSCORE] is String) ||
        !(json[SCOREBYPLAYERNAME] is Map<String, String>)) {
      throw Exception('Malformed Player');
    }

    return LobbyResults._(json[MAXSCORE], json[SCOREBYPLAYERNAME]);
  }
}
