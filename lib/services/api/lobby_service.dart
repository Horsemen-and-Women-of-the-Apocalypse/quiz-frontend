import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/services/api_service.dart';

/// Service for lobby API
class LobbyService extends APIService {

  Future<String> join(String url, String name) async {
    return await post(url, name) as String;
  }
}
