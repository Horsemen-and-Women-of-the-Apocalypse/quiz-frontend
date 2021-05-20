import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/services/api_service.dart';
import 'package:quiz/widgets/quiz_form.dart';

/// Service for quiz API
class QuizService extends APIService {
  /// Get all available quizzes
  Future<List<QuizListItem>> list() async {
    return (await get('quiz/list') as List<dynamic>)
        .map((q) => QuizListItem.fromJSON(q))
        .toList();
  }

  /// Get quiz based on its id
  Future<List<AQuizQuestion>> findById(String id) async {
    return (await get('quiz/$id/questions') as List<dynamic>)
        .map((e) => AQuizQuestion.fromJSON(e))
        .toList();
  }

  /// Answer the given quiz
  Future<SoloQuizResults> answer(String quizId, QuizFormData answers) async {
    return SoloQuizResults.fromJSON(await post('quiz/$quizId/answer', answers));
  }
  
  /// Create the given quiz, returning its id
  Future<String> create(Quiz quiz) async {
    return await post('quiz/create', quiz) as String;
  }
}
