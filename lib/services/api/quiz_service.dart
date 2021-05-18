import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/model/creation/creation.dart';
import 'package:quiz/services/api_service.dart';

/// Service for quiz API
class QuizService extends APIService {
  /// Get all available quizzes
  Future<List<QuizListItem>> list() async {
    return (await get('quiz/list') as List<dynamic>)
        .map((q) => QuizListItem.fromJSON(q))
        .toList();
  }

  Future<List<QuizListItem>> create(Quiz quiz) async {
    return (await post('quiz/create', quiz) as List<dynamic>)
        .map((q) => QuizListItem.fromJSON(q))
        .toList();
  }
}