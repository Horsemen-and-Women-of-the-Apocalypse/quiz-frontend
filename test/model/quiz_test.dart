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
          reason: 'Choices are missing');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON({
                StringMultipleChoiceQuestion.CHOICES_FIELD_NAME:
                    List<String>.empty()
              }),
          throwsException,
          reason: 'Question is missing');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON({
                StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 0,
                StringMultipleChoiceQuestion.CHOICES_FIELD_NAME:
                    List.of(['A', 'B'])
              }),
          throwsException,
          reason: 'Invalid question');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON({
                StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 'Question',
                StringMultipleChoiceQuestion.CHOICES_FIELD_NAME: 'Answers'
              }),
          throwsException,
          reason: 'Invalid choices');
      expect(
          () => StringMultipleChoiceQuestion.fromJSON({
                StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 'Question',
                StringMultipleChoiceQuestion.CHOICES_FIELD_NAME: [0, 1].toList()
              }),
          throwsException,
          reason: 'Invalid choices');
      expect(
          StringMultipleChoiceQuestion.fromJSON({
            StringMultipleChoiceQuestion.QUESTION_FIELD_NAME: 'Question',
            StringMultipleChoiceQuestion.CHOICES_FIELD_NAME: List.of(['A', 'B'])
          }),
          isNotNull);
    });
  });
}
