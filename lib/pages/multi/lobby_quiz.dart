import 'package:flutter/material.dart';
import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/pages/multi/lobby_wait_room.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/widgets/quiz_form.dart';

/// Lobby quiz page
class LobbyQuizPage extends StatefulWidget {
  final String _quizName;
  final String _lobbyId;
  final String _playerId;

  /// Constructor
  LobbyQuizPage(String quizName, String lobbyId, String playerId)
      : _quizName = quizName,
        _lobbyId = lobbyId,
        _playerId = playerId;

  @override
  State<StatefulWidget> createState() {
    return _LobbyQuizPageState(_quizName, _lobbyId, _playerId);
  }
}

class _LobbyQuizPageState extends State<LobbyQuizPage> {
  final LobbyService _service = LobbyService();
  Future<List<AQuizQuestion>>? _questionsFuture;
  final String _quizName;
  final String _lobbyId;
  final String _playerId;

  /// Constructor
  _LobbyQuizPageState(String quizName, String lobbyId, String playerId)
      : _quizName = quizName,
        _lobbyId = lobbyId,
        _playerId = playerId;

  @override
  void initState() {
    super.initState();

    // Get questions
    _questionsFuture = _service.questions(_lobbyId, _playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<AQuizQuestion>>(
            future: _questionsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Failed to load quiz\'s questions',
                    style: TextStyle(color: Colors.red));
              }
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _quizName,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      QuizForm(
                          snapshot.data!, (form) => onComplete(context, form))
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
            }));
  }

  /// Callback called when form is completed
  void onComplete(BuildContext context, QuizFormData form) async {
    try {
      // Send answers
      await _service.answer(_lobbyId, _playerId, form);

      // Go to waiting room
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) => LobbyEndRoomPage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to send answers',
              style: TextStyle(color: Colors.red))));
    }
  }
}
