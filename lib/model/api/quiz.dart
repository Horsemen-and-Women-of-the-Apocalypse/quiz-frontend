/// Quiz returned by /quiz/list
class QuizListItem {
  static const NAME_FIELD_NAME = 'name';
  static const ID_FIELD_NAME = 'id';

  final String id;
  final String name;

  /// Constructor
  QuizListItem(String id, String name)
      : id = id,
        name = name;

  /// Load a QuizListItem from a JSON
  factory QuizListItem.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(ID_FIELD_NAME) ||
        !json.containsKey(NAME_FIELD_NAME) ||
        !(json[ID_FIELD_NAME] is String) ||
        !(json[NAME_FIELD_NAME] is String)) {
      throw Exception('Malformed QuizListItem');
    }

    return QuizListItem(json[ID_FIELD_NAME], json[NAME_FIELD_NAME]);
  }
}

/// Abstract class for question
abstract class AQuizQuestion {
  /// Load a question from a JSON
  static AQuizQuestion fromJSON(Map<String, dynamic> json) {
    return StringMultipleChoiceQuestion.fromJSON(json);
  }
}

/// Question with multiple choices defined by a string
class StringMultipleChoiceQuestion extends AQuizQuestion {
  static const String QUESTION_FIELD_NAME = 'question';
  static const String ANSWERS_FIELD_NAME = 'answers';

  final List<String> answers;
  final String question;

  /// Constructor
  StringMultipleChoiceQuestion(String question, List<String> answers)
      : question = question,
        answers = answers.toList();

  /// Load a StringMultipleChoiceQuestion from a JSON
  factory StringMultipleChoiceQuestion.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(QUESTION_FIELD_NAME) ||
        !json.containsKey(ANSWERS_FIELD_NAME) ||
        !(json[QUESTION_FIELD_NAME] is String) ||
        !(json[ANSWERS_FIELD_NAME] is List<String>)) {
      throw Exception('Malformed StringMultipleChoiceQuestion');
    }

    return StringMultipleChoiceQuestion(
        json[QUESTION_FIELD_NAME], json[ANSWERS_FIELD_NAME]);
  }
}

// Quiz results in solo mode
class SoloQuizResults {
  static const String SCORE_FIELD_NAME = 'score';
  static const String MAX_SCORE_FIELD_NAME = 'maxScore';
  static const String FAILS_FIELD_NAME = 'fails';

  final int score;
  final int maxScore;
  final List<AQuestionFail> fails;

  /// Constructor
  SoloQuizResults(int score, int maxScore, List<AQuestionFail> fails)
      : score = score,
        maxScore = maxScore,
        fails = fails.toList();

  /// Load a SoloQuizResults from a JSON
  factory SoloQuizResults.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(SCORE_FIELD_NAME) ||
        !json.containsKey(MAX_SCORE_FIELD_NAME) ||
        !json.containsKey(FAILS_FIELD_NAME) ||
        !(json[SCORE_FIELD_NAME] is int) ||
        !(json[MAX_SCORE_FIELD_NAME] is int) ||
        !(json[FAILS_FIELD_NAME] is List<dynamic>)) {
      throw Exception('Malformed SoloQuizResults');
    }

    return SoloQuizResults(
        json[SCORE_FIELD_NAME],
        json[MAX_SCORE_FIELD_NAME],
        (json[FAILS_FIELD_NAME] as List<dynamic>)
            .map((e) => AQuestionFail.fromJSON(e))
            .toList());
  }
}

/// Abstract class for a question fail
abstract class AQuestionFail {
  /// Load a AQuestionFail from a JSON
  static AQuestionFail fromJSON(Map<String, dynamic> json) {
    return StringMultipleChoiceQuestionFail.fromJSON(json);
  }
}

/// Question fail for a StringMultipleChoiceQuestion
class StringMultipleChoiceQuestionFail extends AQuestionFail {
  static const String USER_ANSWER_FIELD_NAME = 'userAnswer';
  static const String SOLUTION_FIELD_NAME = 'solution';

  final String userAnswer;
  final String solution;

  /// Constructor
  StringMultipleChoiceQuestionFail(String userAnswer, String solution)
      : userAnswer = userAnswer,
        solution = solution;

  /// Load a StringMultipleChoiceQuestionFail from JSON
  factory StringMultipleChoiceQuestionFail.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(USER_ANSWER_FIELD_NAME) ||
        !json.containsKey(SOLUTION_FIELD_NAME) ||
        !(json[USER_ANSWER_FIELD_NAME] is String) ||
        !(json[SOLUTION_FIELD_NAME] is String)) {
      throw Exception('Malformed StringMultipleChoiceQuestionFail');
    }

    return StringMultipleChoiceQuestionFail(
        json[USER_ANSWER_FIELD_NAME], json[SOLUTION_FIELD_NAME]);
  }
}
