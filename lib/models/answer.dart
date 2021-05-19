import 'english_word.dart';

class Answer {
  final bool answer;
  final EnglishWord word;

  const Answer({
    required this.word,
    required this.answer,
  });

  ///Return true if both user and [EnglishWord]'s validity is the same
  bool get correct => answer == word.valid;
}
