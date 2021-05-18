import 'package:flutter/material.dart';
import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/services/api/quiz_service.dart';

/// Available quizzes dropdown button
class QuizDropdownButton extends StatefulWidget {
  final _QuizDropdownButtonState _state = _QuizDropdownButtonState();

  /// Get selected quiz
  QuizListItem? quiz() {
    return _state._selectedQuiz;
  }

  @override
  State<StatefulWidget> createState() {
    return _state;
  }
}

class _QuizDropdownButtonState extends State<QuizDropdownButton> {
  final QuizService _service = QuizService();
  Future<List<QuizListItem>>? _quizzesFuture;

  QuizListItem? _selectedQuiz;

  @override
  void initState() {
    super.initState();

    // Fetch quizzes and set default
    _quizzesFuture = _service.list();
    _quizzesFuture!.then((quizzes) {
      setState(() {
        _selectedQuiz = quizzes[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return loadedWidget(snapshot.data as List<QuizListItem>);
          }
          if (snapshot.hasError) {
            return Text('Unable to load quizzes',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold));
          }
          return loadingWidget();
        },
        future: _quizzesFuture);
  }

  /// Build widget in its loading state
  Widget loadingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: CircularProgressIndicator(),
        ),
        Text('Loading quizzes...')
      ],
    );
  }

  /// Build widget in its loaded state
  Widget loadedWidget(List<QuizListItem> quizzes) {
    return DropdownButton<QuizListItem>(
      value: _selectedQuiz,
      onChanged: (QuizListItem? quiz) {
        setState(() {
          _selectedQuiz = quiz;
        });
      },
      items: quizzes
          .map((quiz) => DropdownMenuItem(
                value: quiz,
                child: Text(quiz.name),
              ))
          .toList(),
    );
  }
}
