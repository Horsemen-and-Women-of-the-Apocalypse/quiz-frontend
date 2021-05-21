import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/model/api/lobby.dart';
import 'package:quiz/model/creation/creation.dart';
import 'package:quiz/pages/home.dart';
import 'package:quiz/pages/multi/lobby_quiz.dart';
import 'package:quiz/pages/multi/quiz_results_multi.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/utils/lobby_texts.dart';
import 'package:quiz/utils/quiz_text.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
  Future<LobbyInfo>? lobbyInfoFuture;
  LobbyInfo? lobbyInfo;
  io.Socket? socket;

  io.Socket initSocketClient() {
    var socket = io.io(
        _service.url,
        io.OptionBuilder().setPath('/ws').setQuery({
          'lobbyId': widget._lobbyId,
          'playerId': widget._playerId
        }).build());
    socket.on('playerHasJoined', (data) {
      if (lobbyInfo == null) return;
      setState(() {
        lobbyInfo!.playerNames.add(data);
      });
    });
    socket.on('lobby-start', (data) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LobbyQuizPage(
                  lobbyInfo!.quizName, widget._lobbyId, widget._playerId)));
    });
    socket.on('lobby-end', (data) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiQuizResultsPage(widget._lobbyId)));
    });

    return socket;
  }

  @override
  void initState() {
    lobbyInfoFuture = _service.findById(widget._lobbyId, widget._playerId);
    lobbyInfoFuture!.then((value) => lobbyInfo = value);
    socket = initSocketClient();
    super.initState();
  }

  @override
  void dispose() {
    socket?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lobbyInfoFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          '${LobbyPageTexts.LOBBY_USER_NAME} : ${(snapshot.data as LobbyInfo).name}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline3),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          '${QuizPageTexts.INPUT_QUIZ_NAME} : ${(snapshot.data as LobbyInfo).quizName}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          '${LobbyPageTexts.LOBBY_OWNER_NAME} : ${(snapshot.data as LobbyInfo).ownerName}',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('${LobbyPageTexts.LOBBY_ID} : ${widget._lobbyId}'),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: widget._lobbyId));
                        },
                        child: Icon(Icons.copy),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(LobbyPageTexts.PLAYERS),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                      itemCount:
                          (snapshot.data as LobbyInfo).playerNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            Icon(Icons.account_circle_rounded),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text((snapshot.data as LobbyInfo)
                                  .playerNames[index]),
                            ),
                          ],
                        );
                      }),
                )),
                ElevatedButton(
                  onPressed: () {
                    socket?.close();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (r) => false);
                  },
                  child: Text(LobbyPageTexts.LEAVE_LOBBY),
                ),
                if (widget.owner)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await _service.start(
                              widget._lobbyId, widget._playerId);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(LobbyPageTexts.ERROR_START,
                                  style: TextStyle(color: Colors.red))));
                        }
                      },
                      child: Text(LobbyPageTexts.START_GAME),
                    ),
                  )
              ],
            );
          }
          if (snapshot.hasError) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text(LobbyPageTexts.ERROR_GET_LOBBY,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (r) => false),
                      child: Text(LobbyPageTexts.ERROR_BACK))
                ],
              ),
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          );
        },
      ),
    );
  }
}
