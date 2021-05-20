import 'package:flutter/material.dart';
import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/widgets/quiz_form.dart';

/// Solo mode quiz page
class SoloQuizPage extends StatelessWidget {
  final List<AQuizQuestion> _questions;
  final QuizListItem _quiz;

  /// Constructor
  SoloQuizPage(QuizListItem quiz, List<AQuizQuestion> questions)
      : _quiz = quiz,
        _questions = questions.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _quiz.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            QuizForm(_questions, (form) => onComplete(context, form))
          ],
        ),
      ),
    );
  }

  /// Callback called when form is completed
  void onComplete(BuildContext context, QuizFormData form) {
    try {
      // TODO: Send answers to API
      debugPrint('Send answers');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to send answers',
              style: TextStyle(color: Colors.red))));
    }
  }
}
