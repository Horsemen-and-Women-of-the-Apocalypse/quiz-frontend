import 'package:flutter/material.dart';
import 'package:quiz/model/api/lobby.dart';
import 'package:quiz/model/creation/creation.dart';
import 'package:quiz/pages/home.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/utils/lobby_texts.dart';
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
  Future<LobbyInfo>? lobbyInfo;
  io.Socket? socket;

  io.Socket initSocketClient() {
    var socket = io.io(
        'http://localhost:3000',
        io.OptionBuilder().setPath('/ws').setQuery({
          'lobbyId': widget._lobbyId,
          'playerId': widget._playerId
        }).build());
    socket.onConnect((_) {
      print('connect');
    });
    socket.on('newPlayer', (data) {
      (lobbyInfo as LobbyInfo).playerNames.add(data);
    });
    socket.onDisconnect((_) => socket.emit('disconnect'));
    return socket;
  }

  @override
  void initState() {
    lobbyInfo = _service.findById(widget._lobbyId, widget._playerId);
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
