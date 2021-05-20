import 'package:flutter/material.dart';
import 'package:quiz/pages/quiz_creation.dart';
import 'package:quiz/pages/solo/quiz_selection.dart';
import 'package:quiz/utils/page_texts.dart';
import 'package:quiz/widgets/lobby_create_dialog.dart';
import 'package:quiz/widgets/lobby_join_dialog.dart';

/// Home page widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buttonStyle = ElevatedButton.styleFrom(
        textStyle: Theme.of(context).textTheme.headline4);
    const buttonPadding = 25.0;
    var buttonPaddingGenerator = (Widget c) => Padding(
          padding: EdgeInsets.only(bottom: buttonPadding),
          child: c,
        );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: buttonPadding * 2),
                child: Text(
                  'QUIZ',
                  style: Theme.of(context).textTheme.headline1,
                )),
            buttonPaddingGenerator(ElevatedButton(
                key: Key(HomepageTexts.SOLO_BUTTON_TEXT),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuizSelectionPage())),
                style: buttonStyle,
                child: Text(HomepageTexts.SOLO_BUTTON_TEXT))),
            buttonPaddingGenerator(ElevatedButton(
                key: Key(HomepageTexts.LOBBY_CREATION_BUTTON_TEXT),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LobbyCreateDialog(context);
                      });
                },
                style: buttonStyle,
                child: Text(HomepageTexts.LOBBY_CREATION_BUTTON_TEXT))),
            buttonPaddingGenerator(ElevatedButton(
                key: Key(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT),
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LobbyJoinDialog(context);
                      });
                },
                style: buttonStyle,
                child: Text(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT))),
            buttonPaddingGenerator(ElevatedButton(
                key: Key(HomepageTexts.CREATE_QUIZ_BUTTON_TEXT),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizCreationPage(),
                    ),
                  );
                },
                style: buttonStyle,
                child: Text(HomepageTexts.CREATE_QUIZ_BUTTON_TEXT)))
          ],
        ),
      ),
    );
  }
}
