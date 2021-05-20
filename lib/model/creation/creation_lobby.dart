import 'package:quiz/model/api/quiz.dart';

///Class to represent a lobby
class Lobby {
  static const LOBBYID = 'id';
  static const LOBBYNAME = 'name';
  static const QUIZ = 'quiz';
  static const OWNER = 'owner';

  String _id = '';
  String _name = '';
  QuizListItem _quiz;
  Player _owner = Player();

  Lobby._(this._id, this._name, this._quiz, this._owner);

  Lobby(String ownerName, this._name, this._quiz) {
    _owner._name = ownerName;
  }

  String getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  String getOwnerId() {
    return _owner._id;
  }

  String getQuizId() {
    return _quiz.id;
  }

  ///Mapper to Json
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'quizId': _quiz.id,
      'ownerName': _owner._name,
    };
  }

  factory Lobby.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(LOBBYID) ||
        !json.containsKey(LOBBYNAME) ||
        !json.containsKey(QUIZ) ||
        !json.containsKey(OWNER) ||
        !(json[LOBBYID] is String) ||
        !(json[LOBBYNAME] is String) ||
        !(json[QUIZ] is Map<String, dynamic>) ||
        !(json[OWNER] is Map<String, dynamic>)) {
      throw Exception('Malformed Lobby');
    }

    return Lobby._(json[LOBBYID], json[LOBBYNAME],
        QuizListItem.fromJSON(json[QUIZ]), Player.fromJSON(json[OWNER]));
  }
}

class Player {
  static const PLAYERID = 'id';
  static const PLAYERNAME = 'name';

  String _id = '';
  String _name = '';

  Player._(this._id, this._name);
  Player();

  factory Player.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(PLAYERID) ||
        !json.containsKey(PLAYERNAME) ||
        !(json[PLAYERID] is String) ||
        !(json[PLAYERNAME] is String)) {
      throw Exception('Malformed Player');
    }

    return Player._(json[PLAYERID], json[PLAYERNAME]);
  }
}
