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
  static const String CHOICES_FIELD_NAME = 'choices';

  final List<String> answers;
  final String question;

  /// Constructor
  StringMultipleChoiceQuestion(String question, List<String> answers)
      : question = question,
        answers = answers.toList();

  /// Load a StringMultipleChoiceQuestion from a JSON
  factory StringMultipleChoiceQuestion.fromJSON(Map<String, dynamic> json) {
    if (!json.containsKey(QUESTION_FIELD_NAME) ||
        !json.containsKey(CHOICES_FIELD_NAME) ||
        !(json[QUESTION_FIELD_NAME] is String) ||
        !(json[CHOICES_FIELD_NAME] is List<dynamic>) ||
        (json[CHOICES_FIELD_NAME] as List<dynamic>)
            .any((element) => !(element is String))) {
      throw Exception('Malformed StringMultipleChoiceQuestion');
    }

    return StringMultipleChoiceQuestion(
        json[QUESTION_FIELD_NAME],
        (json[CHOICES_FIELD_NAME] as List<dynamic>)
            .map((e) => e as String)
            .toList());
  }
}
