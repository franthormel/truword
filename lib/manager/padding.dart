import 'package:flutter/material.dart';

class PaddingManager {
  //The following are used by:
  //1. Home page
  //2. Settings page
  static const _kHeightHome = .03;
  static const _kWidthHome = .02;

  //The following are used by:
  //1. Game page
  static const _kWidthGame = .09;
  static const _kHeightGame = .05;

  //Display is 411 x 683
  //Vertical is 411 * _kWidthRow = 8.22
  static EdgeInsets minWidthPad(BuildContext context) => _horizontal(
        context: context,
        kHeightFactor: _kWidthHome,
      );

  //Display is 411 x 683
  //Vertical is 411 * _kWidth = 8.22
  //Horizontal is 683 * _kHeight = 27.32
  static EdgeInsets home(BuildContext context) => _symmetric(
        context: context,
        kHeightFactor: _kHeightHome,
        kWidthFactor: _kWidthHome,
      );

  //Display is 411 x 683
  //Vertical is 411 * .02 = 8.22
  //Horizontal is 683 * .04 = 27.32
  ///Returns symmetric [EdgeInsets]
  static EdgeInsets contents(BuildContext context) => _symmetric(
        context: context,
        kHeightFactor: _kHeightGame,
        kWidthFactor: _kWidthGame,
      );

  static EdgeInsets _symmetric({
    required BuildContext context,
    required double kWidthFactor,
    required double kHeightFactor,
  }) {
    final size = MediaQuery.of(context).size;
    final vertical = size.height * kHeightFactor;
    final horizontal = size.width * kWidthFactor;

    return EdgeInsets.symmetric(
      vertical: vertical,
      horizontal: horizontal,
    );
  }

  static EdgeInsets _horizontal({
    required BuildContext context,
    required double kHeightFactor,
  }) {
    final size = MediaQuery.of(context).size;
    final horizontal = size.height * kHeightFactor;

    return EdgeInsets.symmetric(
      horizontal: horizontal,
    );
  }
}
