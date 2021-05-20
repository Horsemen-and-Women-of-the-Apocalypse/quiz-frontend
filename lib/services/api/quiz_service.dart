import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/services/api_service.dart';

/// Service for quiz API
class QuizService extends APIService {
  /// Get all available quizzes
  Future<List<QuizListItem>> list() async {
    return (await get('quiz/list') as List<dynamic>)
        .map((q) => QuizListItem.fromJSON(q))
        .toList();
  }

  // Get quiz based on its id
  Future<List<AQuizQuestion>?> findById(String id) async {
    var data = await get('quiz/$id/questions');
    if (data == null) {
      return data;
    }

    return (data as List<dynamic>)
        .map((e) => AQuizQuestion.fromJSON(e))
        .toList();
  }
}
