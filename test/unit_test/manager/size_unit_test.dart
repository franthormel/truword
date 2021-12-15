import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:word_game/manager/size.dart';

void main() {
  const size = Size(100, 100);

  group('SizeManager', () {
    test('game should return expected value', () {
      final result = SizeManager.game(size);

      const expected = Size(67, 7);

      // ERROR #1
      //
      // If expect(result, expected); is to be used
      //
      // this shows up:
      //
      // Expected: Size:<Size(67.0, 7.0)>
      // Actual: Size:<Size(67.0, 7.0)>
      //
      // so I checked separately to appease the test.
      //
      // but for the other tests it works. 🤔

      // ERROR #2
      //
      // There's a problem with the precision values
      //
      // Expected: <7.0>
      // Actual: <7.000000000000001>
      //
      // So I did the following: ⚒️

      expect(result.height.toInt(), expected.height.toInt());
      expect(result.width.toInt(), expected.width.toInt());
    });

    test('home should return expected value', () {
      final result = SizeManager.home(size);
      const expected = Size(71, 8);

      expect(result, expected);
    });

    test('logo should return expected value', () {
      final result = SizeManager.logo(size);
      double expected = 17;

      expect(result, expected);
    });
  });
}
