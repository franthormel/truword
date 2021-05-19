import 'dart:math';

import 'data/words_false.dart';
import 'data/words_true.dart';

class EnglishWord {
  late String text;
  late bool valid;

  EnglishWord() {
    final random = Random();

    this.valid = random.nextBool();

    this.text = this.valid
        ? wordsTrue[random.nextInt(wordsTrue.length)]
        : wordsFalse[random.nextInt(wordsFalse.length)];
  }
}
