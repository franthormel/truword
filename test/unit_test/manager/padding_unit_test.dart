import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:word_game/manager/padding.dart';

void main() {
  const size = Size(100, 100);

  group('PaddingManager', () {
    test('minWidthPad should return expected value', () {
      final result = PaddingManager.minWidthPad(size);
      const expected = EdgeInsets.symmetric(
        horizontal: 2,
      );

      expect(result, expected);
    });

    test('home should return expected value', () {
      final result = PaddingManager.home(size);
      const expected = EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 2,
      );

      expect(result, expected);
    });

    test('contents should return expected value', () {
      final result = PaddingManager.contents(size);
      const expected = EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 9,
      );

      expect(result, expected);
    });
  });
}
