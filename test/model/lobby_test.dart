import 'package:quiz/model/api/quiz.dart';
import 'package:quiz/model/creation/creation_lobby.dart';
import 'package:test/test.dart';

void main() {
  group('Lobby', () {
    test('fromJSON', () {
      expect(() => Lobby.fromJSON({}), throwsException,
          reason: 'Cannot create a lobby from empty json');
      expect(() => Lobby.fromJSON({Lobby.LOBBYID: '42'}), throwsException,
          reason: 'Name, quiz and owner are missing');
      expect(() => Lobby.fromJSON({Lobby.LOBBYNAME: 'lobby'}), throwsException,
          reason: 'ID, quiz and owner are missing');
      expect(
          () => Lobby.fromJSON({
                Lobby.QUIZ: {
                  QuizListItem.ID_FIELD_NAME: '10',
                  QuizListItem.NAME_FIELD_NAME: 'Quiz'
                }
              }),
          throwsException,
          reason: 'ID, Name and owner are missing');
      expect(
          () => Lobby.fromJSON({
                Lobby.OWNER: {
                  Player.PLAYERID: '10',
                  Player.PLAYERNAME: 'Player'
                }
              }),
          throwsException,
          reason: 'ID, quiz and name are missing');
      expect(
          () => Lobby.fromJSON({
                Lobby.LOBBYID: 42,
                Lobby.LOBBYNAME: 'name',
                Lobby.QUIZ: {
                  QuizListItem.ID_FIELD_NAME: '10',
                  QuizListItem.NAME_FIELD_NAME: 'Quiz'
                },
                Lobby.OWNER: {
                  Player.PLAYERID: '10',
                  Player.PLAYERNAME: 'Player'
                }
              }),
          throwsException,
          reason: 'Invalid id');
      expect(
          () => Lobby.fromJSON({
                Lobby.LOBBYID: '42',
                Lobby.LOBBYNAME: 5,
                Lobby.QUIZ: {
                  QuizListItem.ID_FIELD_NAME: '10',
                  QuizListItem.NAME_FIELD_NAME: 'Quiz'
                },
                Lobby.OWNER: {
                  Player.PLAYERID: '10',
                  Player.PLAYERNAME: 'Player'
                }
              }),
          throwsException,
          reason: 'Invalid name');
      expect(
          () => Lobby.fromJSON({
                Lobby.LOBBYID: '42',
                Lobby.LOBBYNAME: 'name',
                Lobby.QUIZ: {QuizListItem.NAME_FIELD_NAME: 'Quiz'},
                Lobby.OWNER: {
                  Player.PLAYERID: '10',
                  Player.PLAYERNAME: 'Player'
                }
              }),
          throwsException,
          reason: 'Invalid quiz');
      expect(
          () => Lobby.fromJSON({
                Lobby.LOBBYID: '42',
                Lobby.LOBBYNAME: 'name',
                Lobby.QUIZ: {QuizListItem.ID_FIELD_NAME: '10'},
                Lobby.OWNER: {
                  Player.PLAYERID: '10',
                  Player.PLAYERNAME: 'Player'
                }
              }),
          throwsException,
          reason: 'Invalid quiz');
      expect(
          () => Lobby.fromJSON({
                Lobby.LOBBYID: '42',
                Lobby.LOBBYNAME: 'name',
                Lobby.QUIZ: {
                  QuizListItem.ID_FIELD_NAME: '10',
                  QuizListItem.NAME_FIELD_NAME: 'Quiz'
                },
                Lobby.OWNER: {Player.PLAYERID: '10'}
              }),
          throwsException,
          reason: 'Invalid player');
      expect(
          () => Lobby.fromJSON({
                Lobby.LOBBYID: '42',
                Lobby.LOBBYNAME: 'name',
                Lobby.QUIZ: {
                  QuizListItem.ID_FIELD_NAME: '10',
                  QuizListItem.NAME_FIELD_NAME: 'Quiz'
                },
                Lobby.OWNER: {Player.PLAYERNAME: 'Player'}
              }),
          throwsException,
          reason: 'Invalid player');
      expect(
          () => Lobby.fromJSON({
                Lobby.LOBBYID: '42',
                Lobby.LOBBYNAME: 'name',
                Lobby.QUIZ: {
                  QuizListItem.ID_FIELD_NAME: '10',
                  QuizListItem.NAME_FIELD_NAME: 'Quiz'
                },
                Lobby.OWNER: {
                  Player.PLAYERID: '10',
                  Player.PLAYERNAME: 'Player'
                }
              }),
          isNotNull);
    });
  });
}
