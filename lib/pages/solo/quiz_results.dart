import 'package:flutter/material.dart';
import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/pages/home.dart';

/// Quiz results page in solo mode
class SoloQuizResultsPage extends StatelessWidget {
  final SoloQuizResults _results;

  /// Constructor
  SoloQuizResultsPage(SoloQuizResults results) : _results = results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.all(20), children: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 25),
            child: Text(
              '${_results.score} / ${_results.maxScore}',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: (_results.fails.isEmpty
                  ? <Widget>[]
                  : <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          generateTextCard(context, 'User', Colors.blue),
                          generateTextCard(context, 'Solution', Colors.blue)
                        ],
                      )
                    ]) +
              _results.fails
                  .map((e) => generateCorrection(context, e))
                  .toList(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25),
          child: ElevatedButton(
              onPressed: () {
                // Go to home and clear pages stack
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (r) => false);
              },
              child: Text('HOME')),
        )
      ]),
    );
  }

  /// Generate correction from a question fail
  Widget generateCorrection(BuildContext context, AQuestionFail fail) {
    if (fail is StringMultipleChoiceQuestionFail) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          generateTextCard(context,
              fail.userAnswer == null ? '' : fail.userAnswer!, Colors.red),
          generateTextCard(context, fail.solution, Colors.green)
        ],
      );
    }

    throw Exception('Unsupported question fail: ${fail.runtimeType}');
  }

  /// Generate a Card containing the given text
  Card generateTextCard(
      BuildContext context, String text, Color backgroundColor) {
    return Card(
      elevation: 20,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding: EdgeInsets.all(15),
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ))),
    );
  }
}
