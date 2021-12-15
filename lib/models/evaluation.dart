import 'answer.dart';

class Evaluation {
  final List<Answer> answers;

  late int correct;

  Evaluation(this.answers) {
    correct = 0;

    for (Answer answer in answers) {
      if (answer.correct) {
        correct++;
      }
    }
  }

  double get _percentageCorrect {
    double value = 0;

    if (correct > 0) {
      final percent = correct / total;

      value = percent * 100;
    }
    
    return value;
  }

  String get percentCorrectText {
    final percentage = _percentageCorrect;
    final percentIsAWholeNumber = percentage % 1 == 0;

    return percentIsAWholeNumber
        ? "${percentage.toStringAsFixed(0)}%"
        : "${percentage.toStringAsFixed(1)}%";
  }

  int get total => answers.length;

  int get wrong => total - correct;
}
