import 'package:quiz/model/api/lobby.dart';
import 'package:quiz/model/creation/creation_lobby.dart';
import 'package:quiz/services/api_service.dart';

/// Service for lobby API
class LobbyService extends APIService {
  Future<Player> join(String url, String name) async {
    return Player.fromHALFJSON(
        await post(url, {'playerName': name}) as dynamic, name);
  }

  Future<Lobby> create(Lobby lobby) async {
    return Lobby.fromJSON((await post('lobby/create', lobby) as dynamic));
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
}
