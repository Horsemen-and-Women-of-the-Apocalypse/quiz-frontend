import 'package:flutter/material.dart';

/// Lobby end waiting room page
class LobbyEndRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Please wait until quiz end',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    );
  }
}
