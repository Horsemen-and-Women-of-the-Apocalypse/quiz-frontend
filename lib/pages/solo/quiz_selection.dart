import 'package:flutter/material.dart';
import 'package:quiz/pages/solo/quiz.dart';
import 'package:quiz/services/api/quiz_service.dart';
import 'package:quiz/widgets/quiz_dropdown_button.dart';

/// Solo quiz selection page
class QuizSelectionPage extends StatelessWidget {
  final QuizService _service = QuizService();

  @override
  Widget build(BuildContext context) {
    var dropdown = QuizDropdownButton();
    var padding = 15.0;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: padding * 2),
              child: Text(
                'Select a quiz',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: padding), child: dropdown),
            ElevatedButton(
                onPressed: () async {
                  // Start quiz
                  try {
                    var selectedQuiz = dropdown.quiz();
                    if (selectedQuiz == null) {
                      return;
                    }

                    var questions = await _service.findById(selectedQuiz.id);
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SoloQuizPage(selectedQuiz, questions)));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to retrieve selected quiz',
                            style: TextStyle(color: Colors.red))));
                  }
                },
                child: Text('START'))
          ],
        ),
      ),
    );
  }
}
