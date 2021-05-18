import 'package:quiz/model/api/quiz.dart';
import 'package:test/test.dart';

void main() {
  group('QuizListItem', () {
    test('fromJSON', () {
      expect(() => QuizListItem.fromJSON({}), throwsException,
          reason: 'Cannot create a quiz item based on an empty JSON');
      expect(
          () => QuizListItem.fromJSON({QuizListItem.NAME_FIELD_NAME: 'Quiz'}),
          throwsException,
          reason: 'Id is missing');
      expect(() => QuizListItem.fromJSON({QuizListItem.ID_FIELD_NAME: '0'}),
          throwsException,
          reason: 'Name is missing');
      expect(
          () => QuizListItem.fromJSON({
                QuizListItem.ID_FIELD_NAME: 10,
                QuizListItem.NAME_FIELD_NAME: 'Quiz'
              }),
          throwsException,
          reason: 'Invalid id');
      expect(
          () => QuizListItem.fromJSON({
                QuizListItem.ID_FIELD_NAME: '10',
                QuizListItem.NAME_FIELD_NAME: 0
              }),
          throwsException,
          reason: 'Invalid name');
      expect(
          QuizListItem.fromJSON({
            QuizListItem.ID_FIELD_NAME: '10',
            QuizListItem.NAME_FIELD_NAME: 'Quiz'
          }),
          isNotNull);
    });
  });

  group('StringMultipleChoiceQuestion', () {
    test('fromJSON', () {
      expect(() => StringMultipleChoiceQuestion.fromJSON({}), throwsException,
          reason: 'Cannot create a question based on an empty JSON');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON(
              {StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 'Question'}),
          throwsException,
          reason: 'Answers are missing');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON({
                StringMultipleChoiceQuestion.ANSWERS_FIELD_NAME:
                    List<String>.empty()
              }),
          throwsException,
          reason: 'Question is missing');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON({
                StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 0,
                StringMultipleChoiceQuestion.ANSWERS_FIELD_NAME:
                    List.of(['A', 'B'])
              }),
          throwsException,
          reason: 'Invalid question');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON({
                StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 'Question',
                StringMultipleChoiceQuestion.ANSWERS_FIELD_NAME: 'Answers'
              }),
          throwsException,
          reason: 'Invalid answers');
      expect(
          StringMultipleChoiceQuestion.fromJSON({
            StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 'Question',
            StringMultipleChoiceQuestion.ANSWERS_FIELD_NAME: List.of(['A', 'B'])
          }),
          isNotNull);
    });
  });

  group('StringMultipleChoiceQuestionFail', () {
    test('fromJSON', () {
      expect(
          () => StringMultipleChoiceQuestionFail.fromJSON({}), throwsException,
          reason: 'Cannot create a question fail based on an empty JSON');
      expect(
          () => StringMultipleChoiceQuestionFail.fromJSON({
                StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME:
                    'answer'
              }),
          throwsException,
          reason: 'Solution is missing');
      expect(
          () => StringMultipleChoiceQuestionFail.fromJSON(
              {StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'answer'}),
          throwsException,
          reason: 'User\'s answer is missing');
      expect(
          () => StringMultipleChoiceQuestionFail.fromJSON({
                StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME:
                    'answer',
                StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 0
              }),
          throwsException,
          reason: 'Invalid solution');
      expect(
          () => StringMultipleChoiceQuestionFail.fromJSON({
                StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME: 0,
                StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'answer'
              }),
          throwsException,
          reason: 'Invalid user\'s answer');
      expect(
          StringMultipleChoiceQuestionFail.fromJSON({
            StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME: 'answer',
            StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'solution'
          }),
          isNotNull);
    });
  });

  group('SoloQuizResults', () {
    test('fromJSON', () {
      expect(() => SoloQuizResults.fromJSON({}), throwsException,
          reason: 'Cannot create results based on an empty JSON');
      expect(
          () => SoloQuizResults.fromJSON({
                SoloQuizResults.MAX_SCORE_FIELD_NAME: 20,
                SoloQuizResults.FAILS_FIELD_NAME: List.of([
                  {
                    StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME:
                        'A',
                    StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'B'
                  }
                ])
              }),
          throwsException,
          reason: 'Score is missing');
      expect(
          () => SoloQuizResults.fromJSON({
                SoloQuizResults.SCORE_FIELD_NAME: 0,
                SoloQuizResults.FAILS_FIELD_NAME: List.of([
                  {
                    StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME:
                        'A',
                    StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'B'
                  }
                ])
              }),
          throwsException,
          reason: 'Max score is missing');
      expect(
          () => SoloQuizResults.fromJSON({
                SoloQuizResults.SCORE_FIELD_NAME: 0,
                SoloQuizResults.MAX_SCORE_FIELD_NAME: 20,
              }),
          throwsException,
          reason: 'Fails are missing');
      expect(
          () => SoloQuizResults.fromJSON({
                SoloQuizResults.SCORE_FIELD_NAME: 'A',
                SoloQuizResults.MAX_SCORE_FIELD_NAME: 20,
                SoloQuizResults.FAILS_FIELD_NAME: List.of([
                  {
                    StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME:
                        'A',
                    StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'B'
                  }
                ])
              }),
          throwsException,
          reason: 'Invalid score');
      expect(
          () => SoloQuizResults.fromJSON({
                SoloQuizResults.SCORE_FIELD_NAME: 0,
                SoloQuizResults.MAX_SCORE_FIELD_NAME: 'A',
                SoloQuizResults.FAILS_FIELD_NAME: List.of([
                  {
                    StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME:
                        'A',
                    StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'B'
                  }
                ])
              }),
          throwsException,
          reason: 'Invalid max score');
      expect(
          () => SoloQuizResults.fromJSON({
                SoloQuizResults.SCORE_FIELD_NAME: 0,
                SoloQuizResults.MAX_SCORE_FIELD_NAME: 1,
                SoloQuizResults.FAILS_FIELD_NAME: {}
              }),
          throwsException,
          reason: 'Invalid fails');
      expect(
          SoloQuizResults.fromJSON({
            SoloQuizResults.SCORE_FIELD_NAME: 0,
            SoloQuizResults.MAX_SCORE_FIELD_NAME: 1,
            SoloQuizResults.FAILS_FIELD_NAME: List.of([
              {
                StringMultipleChoiceQuestionFail.USER_ANSWER_FIELD_NAME: 'A',
                StringMultipleChoiceQuestionFail.SOLUTION_FIELD_NAME: 'B'
              }
            ])
          }),
          isNotNull);
    });
  });
}
