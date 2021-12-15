import 'package:test/test.dart';
import 'package:word_game/models/answer.dart';
import 'package:word_game/models/english_word.dart';
import 'package:word_game/models/evaluation.dart';

void main() {
  final word = EnglishWord.custom(text: '', valid: true);

  final correctAnswer = Answer(word: word, answer: true);
  final wrongAnswer = Answer(word: word, answer: false);

  group("Evaluation", () {
    group('of an empty list', () {
      final eval = Evaluation(<Answer>[]);

      test('correct should return 0', () {
        final result = eval.correct;
        const expected = 0;

        expect(result, expected);
      });

      test('wrong should return 0', () {
        final result = eval.wrong;
        const expected = 0;

        expect(result, expected);
      });

      test('total should return 0', () {
        final result = eval.total;
        const expected = 0;

        expect(result, expected);
      });

      test('percentCorrectText should return 0%', () {
        final result = eval.percentCorrectText;
        const expected = '0%';

        expect(result, expected);
      });
    });

    group('of a list with one (1) correct answer and no wrong answers', () {
      final eval = Evaluation(<Answer>[correctAnswer]);

      test('correct should return 1', () {
        final result = eval.correct;
        const expected = 1;

        expect(result, expected);
      });

      test('wrong should return 0', () {
        final result = eval.wrong;
        const expected = 0;

        expect(result, expected);
      });

      test('total should return 1', () {
        final result = eval.total;
        const expected = 1;

        expect(result, expected);
      });

      test('percentCorrectText should return 0%', () {
        final result = eval.percentCorrectText;
        const expected = '100%';

        expect(result, expected);
      });
    });

    group('of a list with one (1) wrong answer and no correct answers', () {
      final eval = Evaluation(<Answer>[wrongAnswer]);

      test('correct should return 0', () {
        final result = eval.correct;
        const expected = 0;

        expect(result, expected);
      });

      test('wrong should return 1', () {
        final result = eval.wrong;
        const expected = 1;

        expect(result, expected);
      });

      test('total should return 1', () {
        final result = eval.total;
        const expected = 1;

        expect(result, expected);
      });

      test('percentCorrectText should return 0%', () {
        final result = eval.percentCorrectText;
        const expected = '0%';

        expect(result, expected);
      });
    });

    group('of a list with one (1) wrong answer and one (1) correct answer', () {
      final eval = Evaluation(<Answer>[wrongAnswer, correctAnswer]);

      test('correct should return 1', () {
        final result = eval.correct;
        const expected = 1;

        expect(result, expected);
      });

      test('wrong should return 1', () {
        final result = eval.wrong;
        const expected = 1;

        expect(result, expected);
      });

      test('total should return 2', () {
        final result = eval.total;
        const expected = 2;

        expect(result, expected);
      });

      test('percentCorrectText should return 50%', () {
        final result = eval.percentCorrectText;
        const expected = '50%';

        expect(result, expected);
      });
    });
  });
}
