import 'package:flutter/material.dart';

const String SOLO_BUTTON_TEXT = 'SOLO';
const String LOBBY_CREATION_BUTTON_TEXT = 'CREATE A LOBBY';
const String LOBBY_JOINING_BUTTON_TEXT = 'JOIN A LOBBY';

/// Home page widget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var buttonStyle = ElevatedButton.styleFrom(
        textStyle: Theme.of(context).textTheme.headline4);
    var paddingBetweenButtons = SizedBox(height: 25);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'QUIZ',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: paddingBetweenButtons.height * 4),
          ElevatedButton(
              key: Key(SOLO_BUTTON_TEXT),
              onPressed: null, // TODO: Switch to solo mode page
              style: buttonStyle,
              child: Text(SOLO_BUTTON_TEXT)),
          paddingBetweenButtons,
          ElevatedButton(
              key: Key(LOBBY_CREATION_BUTTON_TEXT),
              onPressed: null, // TODO: Switch to lobby creation page
              style: buttonStyle,
              child: Text(LOBBY_CREATION_BUTTON_TEXT)),
          paddingBetweenButtons,
          ElevatedButton(
              key: Key(LOBBY_JOINING_BUTTON_TEXT),
              onPressed: null, // TODO: Switch to lobby joining page
              style: buttonStyle,
              child: Text(LOBBY_JOINING_BUTTON_TEXT))
        ],
      ),
    );
  }
}
