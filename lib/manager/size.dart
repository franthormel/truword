import 'package:flutter/material.dart';

class SizeManager {
  static Size game(Size size) {
    final width = size.width * .67;
    final height = size.height * .07;

    return Size(width, height);
  }

  static Size home(Size size) {
    final width = size.width * .71;
    final height = size.height * .08;

    return Size(width, height);
  }

  static double logo(Size size) {
    return size.height * .17;
  }
}
