import 'package:quiz/model/api/lobby.dart';
import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/model/creation/creation_lobby.dart';
import 'package:quiz/services/api_service.dart';
import 'package:quiz/widgets/quiz_form.dart';

/// Service for lobby API
class LobbyService extends APIService {
  Future<Player> join(String url, String name) async {
    return Player.fromHALFJSON(
        await post(url, {'playerName': name}) as dynamic, name);
  }

  Future<Lobby> create(Lobby lobby) async {
    return Lobby.fromJSON((await post('lobby/create', lobby) as dynamic));
  }

  Future<Lobby> results(String lobbyId) async {
    return Lobby.fromJSON((await get('lobby/$lobbyId/results') as dynamic));
  }

  Future<String> start(String lobbyId, String playerId) async {
    return (await post('lobby/$lobbyId/start', {'playerId': playerId})
        as dynamic);
  }

  /// Get LobbyInfo based on its id
  Future<LobbyInfo> findById(String lobbyId, String playerId) async {
    return LobbyInfo.fromJSON(
        (await post('lobby/$lobbyId/info', {'playerId': playerId}) as dynamic));
  }

  /// Get questions
  Future<List<AQuizQuestion>> questions(String lobbyId, String playerId) async {
    return (await post('lobby/$lobbyId/questions', {'playerId': playerId})
            as List<dynamic>)
        .map((e) => AQuizQuestion.fromJSON(e))
        .toList();
  }

  /// Send answers
  Future<void> answer(
      String lobbyId, String playerId, QuizFormData form) async {
    return await post('lobby/$lobbyId/player/$playerId/answer', form);
  }
}
