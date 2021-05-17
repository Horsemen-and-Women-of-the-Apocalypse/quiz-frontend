import 'package:flutter/material.dart';
import 'package:quiz/utils/page_texts.dart';

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
                onPressed: null, // TODO: Switch to solo mode page
                style: buttonStyle,
                child: Text(HomepageTexts.SOLO_BUTTON_TEXT))),
            buttonPaddingGenerator(ElevatedButton(
                key: Key(HomepageTexts.LOBBY_CREATION_BUTTON_TEXT),
                onPressed: null, // TODO: Switch to lobby creation page
                style: buttonStyle,
                child: Text(HomepageTexts.LOBBY_CREATION_BUTTON_TEXT))),
            buttonPaddingGenerator(ElevatedButton(
                key: Key(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT),
                onPressed: null, // TODO: Switch to lobby joining page
                style: buttonStyle,
                child: Text(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT)))
          ],
        ),
      ),
    );
  }
}
