import 'package:flutter/material.dart';
import 'package:quiz/model/api/result.dart';
import 'package:quiz/pages/home.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/utils/lobby_texts.dart';

///Widget for [MultiQuizResultsPage] creation
class MultiQuizResultsPage extends StatefulWidget {
  final String _lobbyId;

  MultiQuizResultsPage(this._lobbyId);

  @override
  _MultiQuizResultsPageState createState() => _MultiQuizResultsPageState();
}

///State for [_MultiQuizResultsPageState]
class _MultiQuizResultsPageState extends State<MultiQuizResultsPage> {
  final LobbyService _service = LobbyService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(LobbyPageTexts.RESULTS,
              style: Theme.of(context).textTheme.headline3),
          FutureBuilder<LobbyResults>(
              future: _service.results(widget._lobbyId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: Iterable.generate(
                          snapshot.data!.scoreByPlayerName.length, (index) {
                        return Card(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 25),
                              child: Text(
                                '${index + 1}. ${snapshot.data!.scoreByPlayerName[index].name}',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                            ),
                          ),
                        );
                      }).toList());
                }

                if (snapshot.hasError) {
                  return Text('Failed to get results',
                      style: TextStyle(color: Colors.red));
                }

                return Center(child: CircularProgressIndicator());
              }),
          ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (r) => false),
              child: Text(LobbyPageTexts.LOBBY_BACK_TO_HOME))
        ],
      ),
    );
  }
}
