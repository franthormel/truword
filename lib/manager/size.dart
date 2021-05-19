import 'package:flutter/material.dart';

class SizeManager {
  static const _kBtnGameW = .67;
  static const _kBtnGameH = .07;

  static const _kBtnHomeW = .71;
  static const _kBtnHomeH = .08;

  static const _kLogoH = .17;

  ///Returns button [Size] during the game
  static Size game(Size size) {
    return Size(
      size.width * _kBtnGameW,
      size.height * _kBtnGameH,
    );
  }

  ///Returns button [Size] for the homepage
  static Size home(Size size) {
    return Size(
      size.width * _kBtnHomeW,
      size.height * _kBtnHomeH,
    );
  }

  ///Returns the [double] dimensions for the logo
  static double logo(Size size) {
    return size.height * _kLogoH;
  }
}
