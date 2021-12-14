import 'package:test/test.dart';
import 'package:word_game/models/answer.dart';
import 'package:word_game/models/english_word.dart';

void main() {
  const texts = [
    'incongruous',
    'continental',
    'confrontation',
    'sanctuary',
    'curriculum',
  ];

  group('Answer', () {
    test('correct should return true when expected', () {
      for (final text in texts) {
        final word = EnglishWord.custom(text: text, valid: true);
        final answer = Answer(answer: true, word: word);
        final result = answer.correct;

        expect(result, true);
      }
    });

    test('correct should return false if word is not valid', () {
      for (final text in texts) {
        final word = EnglishWord.custom(text: text, valid: false);
        final answer = Answer(answer: true, word: word);
        final result = answer.correct;

        expect(result, false);
      }
    });

    test('correct should return false if answer is false', () {
      for (final text in texts) {
        final word = EnglishWord.custom(text: text, valid: false);
        final answer = Answer(answer: true, word: word);
        final result = answer.correct;

        expect(result, false);
      }
    });
  });
}
