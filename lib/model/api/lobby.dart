/// Lobby returned by /lobby/$lobby_id/info
class LobbyInfo {
  static const ID = 'id';
  static const NAME = 'name';
  static const QUIZNAME = 'quizName';
  static const OWNERNAME = 'ownerName';
  static const PLAYERNAMES = 'playerNames';

  final String id;
  final String name;
  final String quizName;
  final String ownerName;
  List<String> playerNames;

  /// Constructor
  LobbyInfo._(
      this.id, this.name, this.quizName, this.ownerName, this.playerNames);

  /// Load a QuizListItem from a JSON
  factory LobbyInfo.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(ID) ||
        !json.containsKey(NAME) ||
        !json.containsKey(QUIZNAME) ||
        !json.containsKey(OWNERNAME) ||
        !json.containsKey(PLAYERNAMES) ||
        !(json[ID] is String) ||
        !(json[NAME] is String) ||
        !(json[QUIZNAME] is String) ||
        !(json[OWNERNAME] is String) ||
        !(json[PLAYERNAMES] is List<dynamic>)) {
      throw Exception('Malformed QuizListItem');
    }

    return LobbyInfo._(json[ID], json[NAME], json[QUIZNAME], json[OWNERNAME],
        (json[PLAYERNAMES] as List<dynamic>).map((e) => e as String).toList());
  }
}
