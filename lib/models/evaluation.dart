import 'answer.dart';

// TODO Tests
class Evaluation {
  final List<Answer> answers;

  late int total;
  late int correct;

  Evaluation({
    required this.answers,
  }) {
    total = answers.length;
    correct = 0;

    for (Answer answer in answers) {
      if (answer.correct) {
        correct++;
      }
    }
  }

  int get wrong => total - correct;

  double get percentageCorrect {
    final value = (correct / total) * 100;

    return value.isNaN || value.isInfinite || value <= 0 ? 0 : value;
  }

  ///Returns [String] format of [percentageCorrect]
  ///
  ///[percentageCorrect] with decimal values are rounded to one (1) decimal place.
  String get percentageText {
    final percent = percentageCorrect;

    return percent % 1 == 0
        ? "${percent.toStringAsFixed(0)}%"
        : "${percent.toStringAsFixed(1)}%";
  }
}
