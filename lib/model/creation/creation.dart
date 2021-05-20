///Class to represent a quiz
class Quiz {
  String quizName = '';

  final List<Question> _questions = initQuestion();

  ///[Quiz] constructor
  Quiz();

  ///Return [Question] at index
  Question getQuestionAt(int index) {
    return _questions[index];
  }

  ///Add [Question]
  void addQuestion() {
    _questions.add(Question._());
  }

  ///Remove [Question] at index
  void removeQuestionAt(int index) {
    _questions.removeAt(index);
  }

  ///Get size of [List<Question>]
  int getQuestionsSize() {
    return _questions.length;
  }

  ///Mapper to Json
  Map<String, dynamic> toJson() {
    return {
      'name': quizName,
      'questions': _questions,
    };
  }
}

///Class to represent a question in a [Quiz]
class Question {
  int answer = 0;
  String questionName = '';

  final List<Answer> _answers = initAnswer();

  ///Private [Question] constructor
  Question._();

  ///Return [Answer] at index
  Answer getAnswerAt(int index) {
    return _answers[index];
  }

  ///Add [Answer]
  void addAnswer() {
    _answers.add(Answer._());
  }

  ///Remove [Answer] at index
  void removeAnswerAt(int index) {
    _answers.removeAt(index);
  }

  ///Get size of [List<Question>]
  int getAnswersSize() {
    return _answers.length;
  }

  ///Mapper to Json
  Map<String, dynamic> toJson() {
    return {
      'question': questionName,
      'solutionIndex': answer,
      'choices': _answers.map((e) => e.answerName).toList()
    };
  }
}

///Class to represent an answer in a [Question]
class Answer {
  String answerName = '';

  ///Private [Answer] constructor
  Answer._();
}

///Method to init a list of {Question}
List<Question> initQuestion() {
  return List.generate(1, (index) {
    return Question._();
  });
}

///Method to init a list of {Answer}
List<Answer> initAnswer() {
  return List.generate(3, (index) {
    return Answer._();
  });
}
