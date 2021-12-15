import 'package:test/test.dart';
import 'package:word_game/models/enums.dart';
import 'package:word_game/models/game_settings.dart';

void main() {
  group("GameSettings", () {
    group("Time limit is long", () {
      const settings = GameSettings(TimeLimit.long);

      test('seconds should return 120', () {
        final result = settings.seconds;
        const expected = 120;

        expect(result, expected);
      });

      test('secondsRemainder should return 0', () {
        final result = settings.secondsRemainder;
        const expected = 0;

        expect(result, expected);
      });

      test('timeLimitText should return Long', () {
        final result = settings.timeLimitText;
        const expected = "Long";

        expect(result, expected);
      });

      test('timeLimitFormat should return 2:00', () {
        final result = settings.timeLimitFormat;
        const expected = "2:00";

        expect(result, expected);
      });

      test('results should return Results (Long)', () {
        final result = settings.results;
        const expected = "Results (Long)";

        expect(result, expected);
      });
    });

    group("Time limit is regular", () {
      const settings = GameSettings(TimeLimit.regular);

      test('seconds should return 60', () {
        final result = settings.seconds;
        const expected = 60;

        expect(result, expected);
      });

      test('secondsRemainder should return 0', () {
        final result = settings.secondsRemainder;
        const expected = 0;

        expect(result, expected);
      });

      test('timeLimitText should return Regular', () {
        final result = settings.timeLimitText;
        const expected = "Regular";

        expect(result, expected);
      });

      test('timeLimitFormat should return 1:00', () {
        final result = settings.timeLimitFormat;
        const expected = "1:00";

        expect(result, expected);
      });

      test('results should return Results (Regular)', () {
        final result = settings.results;
        const expected = "Results (Regular)";

        expect(result, expected);
      });
    });

    group("Time limit is quick", () {
      const settings = GameSettings(TimeLimit.quick);

      test('seconds should return 30', () {
        final result = settings.seconds;
        const expected = 30;

        expect(result, expected);
      });

      test('secondsRemainder should return 30', () {
        final result = settings.secondsRemainder;
        const expected = 30;

        expect(result, expected);
      });

      test('timeLimitText should return Quick', () {
        final result = settings.timeLimitText;
        const expected = "Quick";

        expect(result, expected);
      });

      test('timeLimitFormat should return 0:30', () {
        final result = settings.timeLimitFormat;
        const expected = "0:30";

        expect(result, expected);
      });

      test('results should return Results (Quick)', () {
        final result = settings.results;
        const expected = "Results (Quick)";

        expect(result, expected);
      });
    });
  });
}
