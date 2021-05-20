import 'package:quiz/model/api/quiz.dart';

///Class to represent a lobby
class Lobby {

  String name = '';
  QuizListItem? quiz;
  String ownerName = '';

  ///Mapper to Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quizId': quiz!.id,
      'ownerName': ownerName,
    };
  }
}