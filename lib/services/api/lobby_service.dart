import 'package:quiz/model/api/lobby.dart';
import 'package:quiz/model/creation/creation_lobby.dart';
import 'package:quiz/services/api_service.dart';

/// Service for lobby API
class LobbyService extends APIService {
  Future<String> join(String url, String name) async {
    return await post(url, name) as String;
  }

  Future<Lobby> create(Lobby lobby) async {
    return (await post('lobby/create', lobby) as dynamic)
        .map((e) => Lobby.fromJSON(e));
  }

  /// Get LobbyInfo based on its id
  Future<LobbyInfo> findById(String lobbyId, String playerId) async {
    return (await get('/lobby/$lobbyId/info') as dynamic)
        .map((e) => LobbyInfo.fromJSON(e));
  }
}
