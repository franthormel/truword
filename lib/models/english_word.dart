import 'dart:math';

import 'data/words_false.dart';
import 'data/words_true.dart';

class EnglishWord {
  late String text;
  late bool valid;

  EnglishWord() {
    final random = Random();

    valid = random.nextBool();

    text = valid
        ? wordsTrue[random.nextInt(wordsTrue.length)]
        : wordsFalse[random.nextInt(wordsFalse.length)];
  }

  EnglishWord.custom({required this.text, required this.valid});
}
