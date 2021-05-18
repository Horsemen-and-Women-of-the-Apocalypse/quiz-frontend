import 'package:flutter/material.dart';

class Quiz {
  final quizController = TextEditingController();

  String quizName = '';
  List<Question>? questions;

  Quiz() {
    questions = initQuestion();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': quizName,
      'questions': questions,
    };
  }
}

class Question {
  final questionController = TextEditingController();
  int answer = 0;

  String questionName = '';
  List<Answer>? answers;

  Question() {
    answers = initAnswer();
  }

  Map<String, dynamic> toJson() {
    var answerResponse = [];

    answers!.forEach((element) { answerResponse.add(element.answerName );});

    return {
      'question': questionName,
      'solutionIndex': answer,
      'choices': answerResponse
    };
  }
}

class Answer {
  final answerController = TextEditingController();

  String answerName = '';

  Answer();
}

List<Question> initQuestion() {
  return List.generate(1, (index) {
    return Question();
  });
}

List<Answer> initAnswer() {
  return List.generate(3, (index) {
    return Answer();
  });
}
