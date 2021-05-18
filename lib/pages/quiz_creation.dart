import 'package:flutter/material.dart';
import 'package:quiz/model/creation/creation.dart';
import 'package:quiz/services/api/quiz_service.dart';
import 'package:quiz/utils/quiz_text.dart';

class QuizCreationPage extends StatefulWidget {
  @override
  _QuizCreationPageState createState() => _QuizCreationPageState();
}

class _QuizCreationPageState extends State<QuizCreationPage> {
  final _formKey = GlobalKey<FormState>();

  final QuizService _service = QuizService();

  Quiz quiz = Quiz();

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
                padding: EdgeInsets.only(bottom: padding * 2),
                child: Text(
                  QuizPageTexts.TITLE,
                  style: Theme.of(context).textTheme.headline3,
                )),
            Padding(
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  controller: quiz.quizController,
                  onChanged: (value) {
                    setState(() {
                      quiz.quizName = value;
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
                  itemCount: quiz.questions!.length,
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
                            controller:
                                quiz.questions![index].questionController,
                            onChanged: (value) {
                              setState(() {
                                quiz.questions![index].questionName = value;
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
                          leading: (quiz.questions!.length > 1)
                              ? IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      quiz.questions!.removeAt(index);
                                    });
                                  },
                                )
                              : null,
                          trailing: IconButton(
                            key: Key(QuizPageTexts.ADD_ANSWER),
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quiz.questions!.add(Question());
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
                                    height: (quiz.questions![index].answers!
                                                .length *
                                            80)
                                        .toDouble(),
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: ListView.builder(
                                        itemCount: quiz
                                            .questions![index].answers!.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return ListTile(
                                            title: TextFormField(
                                              controller: quiz.questions![index]
                                                  .answers![i].answerController,
                                              onChanged: (value) {
                                                setState(() {
                                                  quiz
                                                      .questions![index]
                                                      .answers![i]
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
                                                color: (quiz.questions![index]
                                                            .answer ==
                                                        i)
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              decoration: InputDecoration(
                                                  hintText: QuizPageTexts
                                                      .INPUT_ANSWER),
                                            ),
                                            leading: (quiz.questions![index]
                                                        .answers!.length >
                                                    3)
                                                ? IconButton(
                                                    icon: Icon(Icons.delete),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (quiz
                                                                .questions![
                                                                    index]
                                                                .answer >=
                                                            i) {
                                                          quiz.questions![index]
                                                              .answer = 0;
                                                        }
                                                        quiz.questions![index]
                                                            .answers!
                                                            .removeAt(i);
                                                      });
                                                    },
                                                  )
                                                : null,
                                            trailing: Radio(
                                              value: i,
                                              groupValue:
                                                  quiz.questions![index].answer,
                                              onChanged: (int? newValue) => {
                                                setState(() {
                                                  quiz.questions![index]
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
                                            quiz.questions![index].answers!
                                                .add(Answer());
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
                        await _service.create(quiz);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(QuizPageTexts.ERROR_SUBMIT)));
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
