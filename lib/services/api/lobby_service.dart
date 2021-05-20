import 'package:quiz/model/creation/creation_lobby.dart';
import 'package:quiz/services/api_service.dart';

/// Service for lobby API
class LobbyService extends APIService {

  Future<String> join(String url, String name) async {
    return await post(url, name) as String;
  }

  Future<String> create(Lobby lobby) async {
    return (await post('lobby/create', lobby) as String);
  }
}
