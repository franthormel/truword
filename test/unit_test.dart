import 'package:test/test.dart';
import 'package:word_game/models/answer.dart';
import 'package:word_game/models/enums.dart';
import 'package:word_game/models/evaluation.dart';
import 'package:word_game/models/game_settings.dart';

void main() {
  group("Models.Evaluation", () {
    test("Evaluate empty list", () {
      final eval = Evaluation(
        answers: <Answer>[],
      );

      expect(eval.correct, 0);
      expect(eval.wrong, 0);
      expect(eval.total, 0);
      expect(eval.percentageCorrect, 0);
      expect(eval.percentageText, "0%");
    });
  });

  group("Models.GameSettings", () {
    test("Time limit set to long", () {
      const settings = GameSettings(
        timeLimit: TimeLimit.long,
      );

      expect(settings.seconds, 120);
      expect(settings.secondsRemainder, 0);
      expect(settings.timeLimitText(), "Long");
      expect(settings.timeLimitFormat(), "2:00");
      expect(settings.results, "Results (Long)");
    });

    test("Time limit set to regular", () {
      const settings = GameSettings(
        timeLimit: TimeLimit.regular,
      );

      expect(settings.seconds, 60);
      expect(settings.secondsRemainder, 0);
      expect(settings.timeLimitText(), "Regular");
      expect(settings.timeLimitFormat(), "1:00");
      expect(settings.results, "Results (Regular)");
    });

    test("Time limit set to quick", () {
      const settings = GameSettings(
        timeLimit: TimeLimit.quick,
      );

      expect(settings.seconds, 30);
      expect(settings.secondsRemainder, 30);
      expect(settings.timeLimitText(), "Quick");
      expect(settings.timeLimitFormat(), "0:30");
      expect(settings.results, "Results (Quick)");
    });
  });
}
