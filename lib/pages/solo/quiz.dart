import 'package:flutter/material.dart';
import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/pages/solo/quiz_results.dart';
import 'package:quiz/services/api/quiz_service.dart';
import 'package:quiz/widgets/quiz_form.dart';

/// Solo mode quiz page
class SoloQuizPage extends StatelessWidget {
  final QuizService _service = QuizService();
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
  void onComplete(BuildContext context, QuizFormData form) async {
    try {
      var results = await _service.answer(_quiz.id, form);

      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SoloQuizResultsPage(results)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to send answers',
              style: TextStyle(color: Colors.red))));
    }
  }
}
