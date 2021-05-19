import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/widgets/quiz_dropdown_button.dart';

/// Solo quiz selection page
class QuizSelectionPage extends StatelessWidget {
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
                onPressed: () {
                  // TODO: Start quiz
                },
                child: Text('START'))
          ],
        ),
      ),
    );
  }
}
