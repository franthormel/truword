import 'package:test/test.dart';
import 'package:word_game/models/enums.dart';
import 'package:word_game/models/game_settings.dart';
import 'package:word_game/models/game_state.dart';

void main() {
  const settings = GameSettings(TimeLimit.quick);
  final gameState = GameState(settings);

  group('GameState', () {
    test('canPause should return expected value', () {
      final result = gameState.canPause;
      const expected = true;

      expect(result, expected);
    });

    test('enoughTimeLeft should return expected value', () {
      final result = gameState.enoughTimeLeft;
      const expected = true;

      expect(result, expected);
    });

    test('remainingSeconds should return expected value', () {
      final result = gameState.remainingSeconds;
      final expected = settings.seconds;

      expect(result, expected);
    });

    test('textRemainingSeconds should return expected value', () {
      final result = gameState.textRemainingSeconds;
      const expected = '30 s';

      expect(result, expected);
    });
  });
}
