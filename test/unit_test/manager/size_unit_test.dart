import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:word_game/manager/size.dart';

void main() {
  const size = Size(100, 100);

  group('SizeManager', () {
    test('game should return expected value', () {
      final result = SizeManager.game(size);
      const expected = Size(67, 7);

      expect(result, expected);
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
