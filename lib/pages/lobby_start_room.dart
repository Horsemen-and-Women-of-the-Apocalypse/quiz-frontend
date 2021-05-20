import 'package:flutter/material.dart';
import 'package:quiz/model/api/lobby.dart';
import 'package:quiz/model/creation/creation.dart';
import 'package:quiz/pages/home.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/services/api/quiz_service.dart';
import 'package:quiz/utils/lobby_texts.dart';
import 'package:quiz/utils/quiz_text.dart';

///Widget for [Quiz] creation
class LobbyStartPage extends StatefulWidget {
  final String _lobbyId;
  final String _playerId;
  final bool owner;

  LobbyStartPage(this._lobbyId, this._playerId, this.owner);

  @override
  _LobbyStartPageState createState() => _LobbyStartPageState();
}

///State for [QuizCreationPage]
class _LobbyStartPageState extends State<LobbyStartPage> {
  final LobbyService _service = LobbyService();
  Future<LobbyInfo>? lobbyInfo;

  @override
  void initState() {
    lobbyInfo = _service.findById(widget._lobbyId, widget._playerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lobbyInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text((snapshot.data as LobbyInfo).name,
                    style: Theme.of(context).textTheme.headline3),
                Text((snapshot.data as LobbyInfo).quizName,
                    style: Theme.of(context).textTheme.headline2),
                Text((snapshot.data as LobbyInfo).ownerName,
                    style: Theme.of(context).textTheme.headline2),
                Expanded(
                    child: ListView.builder(
                        itemCount:
                            (snapshot.data as LobbyInfo).playerNames.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                              (snapshot.data as LobbyInfo).playerNames[index]);
                        })),
                if (widget.owner)
                  ElevatedButton(
                    onPressed: () => null, //TODO
                    child: Text(LobbyPageTexts.START_GAME),
                  )
              ],
            );
          }
          if (snapshot.hasError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Unable to get lobby',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
                ElevatedButton(
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (r) => false),
                    child: Text(LobbyPageTexts.ERROR_BACK))
              ],
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          );
        },
      ),
    );
  }
}
