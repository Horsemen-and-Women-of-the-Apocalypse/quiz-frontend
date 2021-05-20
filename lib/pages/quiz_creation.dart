import 'package:flutter/material.dart';
import 'package:quiz/model/creation/creation.dart';
import 'package:quiz/pages/home.dart';
import 'package:quiz/services/api/quiz_service.dart';
import 'package:quiz/utils/quiz_text.dart';

///Widget for [Quiz] creation
class QuizCreationPage extends StatefulWidget {
  @override
  _QuizCreationPageState createState() => _QuizCreationPageState();
}

///State for [QuizCreationPage]
class _QuizCreationPageState extends State<QuizCreationPage> {
  final _formKey = GlobalKey<FormState>();
  final QuizService _service = QuizService();
  final Quiz _quiz = Quiz();

  var padding = 15.0;

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
                padding: EdgeInsets.fromLTRB(0, padding * 2, 0, padding * 2),
                child: Text(
                  QuizPageTexts.TITLE,
                  style: Theme.of(context).textTheme.headline3,
                )),
            Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      _quiz.quizName = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return QuizPageTexts.ERROR_EMPTY;
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(hintText: QuizPageTexts.INPUT_QUIZ_NAME),
                )),
            Flexible(
              child: ListView.builder(
                  itemCount: _quiz.getQuestionsSize(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(padding),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _quiz.getQuestionAt(index).questionName = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return QuizPageTexts.ERROR_EMPTY;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: QuizPageTexts.INPUT_QUESTION),
                          ),
                          leading: (_quiz.getQuestionsSize() > 1)
                              ? IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _quiz.removeQuestionAt(index);
                                    });
                                  },
                                )
                              : null,
                          trailing: IconButton(
                            key: Key(QuizPageTexts.ADD_ANSWER),
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _quiz.addQuestion();
                              });
                            },
                          ),
                          subtitle: Padding(
                              padding: EdgeInsets.only(top: padding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: (_quiz
                                                .getQuestionAt(index)
                                                .getAnswersSize() *
                                            80)
                                        .toDouble(),
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: ListView.builder(
                                        itemCount: _quiz
                                            .getQuestionAt(index)
                                            .getAnswersSize(),
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return ListTile(
                                            title: TextFormField(
                                              onChanged: (value) {
                                                setState(() {
                                                  _quiz
                                                      .getQuestionAt(index)
                                                      .getAnswerAt(i)
                                                      .answerName = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return QuizPageTexts
                                                      .ERROR_EMPTY;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(
                                                color: (_quiz
                                                            .getQuestionAt(
                                                                index)
                                                            .answer ==
                                                        i)
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              decoration: InputDecoration(
                                                  hintText: QuizPageTexts
                                                      .INPUT_ANSWER),
                                            ),
                                            leading: (_quiz
                                                        .getQuestionAt(index)
                                                        .getAnswersSize() >
                                                    3)
                                                ? IconButton(
                                                    icon: Icon(Icons.delete),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (_quiz
                                                                .getQuestionAt(
                                                                    index)
                                                                .answer >=
                                                            i) {
                                                          _quiz
                                                              .getQuestionAt(
                                                                  index)
                                                              .answer = 0;
                                                        }
                                                        _quiz
                                                            .getQuestionAt(
                                                                index)
                                                            .removeAnswerAt(i);
                                                      });
                                                    },
                                                  )
                                                : null,
                                            trailing: Radio(
                                              value: i,
                                              groupValue: _quiz
                                                  .getQuestionAt(index)
                                                  .answer,
                                              onChanged: (int? newValue) => {
                                                setState(() {
                                                  _quiz
                                                          .getQuestionAt(index)
                                                          .answer =
                                                      (newValue)!.toInt();
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
                                            _quiz
                                                .getQuestionAt(index)
                                                .addAnswer();
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: ElevatedButton(
                  key: Key(QuizPageTexts.SUBMIT),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _service.create(_quiz);
                        await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (r) => false);
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(QuizPageTexts.ERROR_SUBMIT,
                                style: TextStyle(color: Colors.red))));
                      }
                    }
                  },
                  child: Text(QuizPageTexts.SUBMIT)),
            ),
          ],
        ),
      ),
    );
  }
}
