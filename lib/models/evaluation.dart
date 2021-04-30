import 'answer.dart';

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
      if (answer.isCorrect) {
        correct++;
      }
    }
  }

  ///Calculate the wrong answers by subtracting [correct] from [total]
  int get wrong => total - correct;

  ///Returns [double] as percentage between [correct] over [total]
  ///
  /// If resulting value is invalid returns 0
  double get percentCorrect {
    final value = (correct / total) * 100;

    return value.isNaN || value.isInfinite || value <= 0 ? 0 : value;
  }

  ///Returns [String] format of [percentage]
  ///
  ///[percentage] with decimal values are rounded to one (1) decimal place.
  String percentCorrectString() {
    final percent = percentCorrect;

    return percent % 1 == 0
        ? "${percent.toStringAsFixed(0)}%"
        : "${percent.toStringAsFixed(1)}%";
  }
}
