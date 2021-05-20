import 'package:flutter/material.dart';
import 'package:quiz/model/api/lobby.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(LobbyPageTexts.RESULTS,
              style: Theme.of(context).textTheme.headline3),
          FutureBuilder(
              future: _service.results(widget._lobbyId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(LobbyPageTexts.RESULTS),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: ListView.builder(
                              itemCount: (snapshot.data as LobbyResults)
                                  .scoreByPlayerName
                                  .length,
                              itemBuilder: (context, index) {
                                switch (index) {
                                  case 0:
                                    return Row(
                                      children: [
                                        Icon(Icons.looks_one_outlined),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                              (snapshot.data as LobbyInfo)
                                                  .playerNames[index]),
                                        ),
                                      ],
                                    );
                                  case 1:
                                    return Row(
                                      children: [
                                        Icon(Icons.looks_two_outlined),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                              (snapshot.data as LobbyInfo)
                                                  .playerNames[index]),
                                        ),
                                      ],
                                    );
                                  case 2:
                                    return Row(
                                      children: [
                                        Icon(Icons.looks_3_outlined),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                              (snapshot.data as LobbyInfo)
                                                  .playerNames[index]),
                                        ),
                                      ],
                                    );
                                  default:
                                    return Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                              (snapshot.data as LobbyInfo)
                                                  .playerNames[index]),
                                        ),
                                      ],
                                    );
                                }
                              }),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                              (r) => false),
                          child: Text(LobbyPageTexts.ERROR_BACK))
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
                          child: Text(LobbyPageTexts.ERROR_GET_RESULTS,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ElevatedButton(
                            onPressed: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
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
              })
        ],
      ),
    );
  }
}
