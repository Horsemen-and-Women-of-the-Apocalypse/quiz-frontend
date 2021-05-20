import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/utils/lobby_texts.dart';
import 'package:quiz/utils/page_texts.dart';

class LobbyJoinDialog extends StatelessWidget {
  final LobbyService _service = LobbyService();
  final BuildContext context;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lobbyIdController = TextEditingController();

  LobbyJoinDialog(this.context) ;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Row (
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close)),
          )
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: LobbyPageTexts.LOBBY_USER_NAME,
                  icon: Icon(Icons.account_circle_rounded),
                ),
              ),
              TextFormField(
                controller: lobbyIdController,
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
              await _service.join('/lobby/${lobbyIdController.text}/join', nameController.text);
              
              //TODO PUSH
            },
          child: Text(HomepageTexts.LOBBY_JOINING_BUTTON_TEXT),),
      ],
    );
  }
}