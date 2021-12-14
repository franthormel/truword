import 'english_word.dart';

class Answer {
  final bool answer;
  final EnglishWord word;

  const Answer({
    required this.word,
    required this.answer,
  });

  bool get correct => answer == word.valid;
}
