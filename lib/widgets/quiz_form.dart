import 'package:flutter/material.dart';
import 'package:quiz/model/api/quiz.dart';

/// Quiz form widget
class QuizForm extends StatefulWidget {
  final void Function(QuizFormData) _onComplete;
  final List<AQuizQuestion> _questions;

  /// Constructor
  QuizForm(
      List<AQuizQuestion> questions, void Function(QuizFormData) onComplete)
      : _questions = questions.toList(),
        _onComplete = onComplete;

  @override
  State<StatefulWidget> createState() {
    return _QuizFormState(_questions, _onComplete);
  }
}

/// Quiz form data
class QuizFormData {
  final List<Object?> answers;

  /// Constructor
  QuizFormData(List<AQuizQuestion> questions)
      : answers = List.generate(questions.length, (index) => null);

  /// Convert object into a JSON
  Map<String, dynamic> toJson() {
    return {'answers': answers};
  }
}

class _QuizFormState extends State<QuizForm> {
  final void Function(QuizFormData) _onComplete;
  final List<AQuizQuestion> _questions;
  final QuizFormData _form;
  int _stepIndex = 0;

  _QuizFormState(
      List<AQuizQuestion> questions, void Function(QuizFormData) onComplete)
      : _questions = questions.toList(),
        _form = QuizFormData(questions),
        _onComplete = onComplete;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _stepIndex,
      physics: ClampingScrollPhysics(),
      onStepCancel: () {
        if (_stepIndex - 1 < 0) {
          return;
        }

        setState(() {
          _stepIndex--;
        });
      },
      onStepContinue: () {
        if (_stepIndex + 1 >= _questions.length) {
          _onComplete(_form);
          return;
        }

        setState(() {
          _stepIndex++;
        });
      },
      steps: Iterable.generate(
          _questions.length, (i) => generateStep(_questions[i], i)).toList(),
    );
  }

  /// Generate a step based on the given question
  Step generateStep(AQuizQuestion question, int questionIndex) {
    if (question is StringMultipleChoiceQuestion) {
      return Step(
          title: Text(question.question),
          content: DropdownButton<Object>(
              onChanged: (newValue) {
                setState(() {
                  _form.answers[questionIndex] = newValue;
                });
              },
              value: _form.answers[questionIndex],
              items: question.answers
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList()));
    }

    throw Exception('Unsupported question type: ${question.runtimeType}');
  }
}
