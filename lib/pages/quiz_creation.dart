import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quiz/utils/quiz_text.dart';

class QuizCreationPage extends StatefulWidget {
  @override
  _QuizCreationPageState createState() => _QuizCreationPageState();
}

class _QuizCreationPageState extends State<QuizCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final _formController = TextEditingController();

  List<Question> _questions = initQuestion();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: _formController,
                  decoration:
                      InputDecoration(hintText: QuizPageTexts.INPUT_QUIZ_NAME),
                )),
            Flexible(
              child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: TextFormField(
                        controller: _questions[index].questionController,
                        decoration: InputDecoration(
                            hintText: QuizPageTexts.INPUT_QUESTION),
                      ),
                      leading: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _questions.removeAt(index);
                          });
                        },
                      ),
                      trailing: IconButton(
                        key: Key(QuizPageTexts.ADD_ANSWER),
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _questions.add(Question());
                          });
                        },
                      ),
                      subtitle: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: (_questions[index].answers.length * 60)
                                    .toDouble(),
                                width: MediaQuery.of(context).size.width / 4,
                                child: ListView.builder(
                                    itemCount: _questions[index].answers.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return ListTile(
                                        title: TextFormField(
                                          controller: _questions[index]
                                              .answers[i]
                                              .answerController,
                                          style: TextStyle(color:(_questions[index].answer == i) ? Colors.green : Colors.red,),
                                          decoration: InputDecoration(
                                              hintText:
                                                  QuizPageTexts.INPUT_ANSWER),
                                        ),
                                        leading: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            setState(() {
                                              _questions[index]
                                                  .answers
                                                  .removeAt(i);
                                            });
                                          },
                                        ),
                                        trailing: Radio(
                                          value: i,
                                          groupValue: _questions[index].answer,
                                          onChanged: (int newValue) => {
                                            setState(() {
                                              _questions[index].answer =
                                                  newValue;
                                            })
                                          },
                                        ),
                                      );
                                    }),
                              ),
                              Row(
                                children: [
                                  Text(QuizPageTexts.ADD_ANSWER),
                                  IconButton(
                                    key: Key(QuizPageTexts.ADD_ANSWER),
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        _questions[index].answers.add(Answer());
                                      });
                                    },
                                  )
                                ],
                              ),
                            ],
                          )),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                  key: Key(QuizPageTexts.SUBMIT),
                  onPressed: () {
                    setState(() {
                      //TODO SUBMIT
                    });
                  },
                  child: Text(QuizPageTexts.SUBMIT)),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final questionController = TextEditingController();
  int answer = 0;

  List<Answer> answers;

  Question() {
    answers = initAnswer();
  }
}

class Answer {
  final answerController = TextEditingController();

  Answer();
}

List<Question> initQuestion() {
  return List.generate(1, (index) {
    return Question();
  });
}

List<Answer> initAnswer() {
  return List.generate(3, (index) {
    return Answer();
  });
}
