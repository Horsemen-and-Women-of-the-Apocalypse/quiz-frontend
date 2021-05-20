import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/remyc/android-workspace/quizfrontend/lib/pages/multi/lobby_start_room.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/utils/lobby_texts.dart';
import 'package:quiz/utils/page_texts.dart';

class LobbyJoinDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LobbyService _service = LobbyService();
  final BuildContext context;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lobbyIdController = TextEditingController();

  LobbyJoinDialog(this.context);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: () => Navigator.pop(context), child: Icon(Icons.close)),
          )
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LobbyPageTexts.ERROR_NAME_EMPTY;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: LobbyPageTexts.LOBBY_USER_NAME,
                  icon: Icon(Icons.account_circle_rounded),
                ),
              ),
              TextFormField(
                controller: lobbyIdController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LobbyPageTexts.ERROR_ID_EMPTY;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: LobbyPageTexts.LOBBY_ID,
                  icon: Icon(Icons.videogame_asset),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                var playerId = await _service.join(
                    '/lobby/${lobbyIdController.text}/join',
                    nameController.text);
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LobbyStartPage(
                            lobbyIdController.text, playerId, false)));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(LobbyPageTexts.ERROR_SUBMIT,
                        style: TextStyle(color: Colors.red))));
              }
            }
          },
          child: Text(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT),
        ),
      ],
    );
  }
}
