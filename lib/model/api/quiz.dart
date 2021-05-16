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
        !json.containsKey(NAME_FIELD_NAME)) {
      throw Exception('Malformed QuizListItem');
    }

    return QuizListItem(json[ID_FIELD_NAME], json[NAME_FIELD_NAME]);
  }
}
