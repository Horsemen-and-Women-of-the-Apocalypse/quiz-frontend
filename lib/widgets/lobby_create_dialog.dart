import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/model/creation/creation_lobby.dart';
import 'package:quiz/services/api/lobby_service.dart';
import 'package:quiz/utils/lobby_texts.dart';
import 'package:quiz/utils/page_texts.dart';
import 'package:quiz/widgets/quiz_dropdown_button.dart';

class LobbyCreateDialog extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final LobbyService _service = LobbyService();
  final BuildContext context;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();

  final Lobby lobby = Lobby();
  final Widget dropdown = QuizDropdownButton();

  LobbyCreateDialog(this.context);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(HomepageTexts.LOBBY_CREATION_BUTTON_TEXT),
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
                  icon: Icon(Icons.house),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                child: Row(
                  children: [
                    Icon(Icons.question_answer),
                    Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: dropdown)
                  ],
                ),
              ),
              TextFormField(
                controller: ownerNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LobbyPageTexts.ERROR_ID_EMPTY;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: LobbyPageTexts.LOBBY_OWNER_ID,
                  icon: Icon(Icons.account_circle_rounded),
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
                await _service.create(lobby);
                // TODO: Switch to lobby
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(LobbyPageTexts.ERROR_SUBMIT,
                        style: TextStyle(color: Colors.red))));
              }
            }
          },
          child: Text(HomepageTexts.LOBBY_CREATION_BUTTON_TEXT),
        ),
      ],
    );
  }
}
