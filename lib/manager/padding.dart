import 'package:flutter/material.dart';

class PaddingManager {
  static EdgeInsets minWidthPad(Size size) {
    return EdgeInsets.symmetric(
      horizontal: size.height * .02,
    );
  }

  static EdgeInsets home(Size size) {
    return EdgeInsets.symmetric(
      vertical: size.height * .03,
      horizontal: size.width * .02,
    );
  }

  static EdgeInsets contents(Size size) {
    return EdgeInsets.symmetric(
      vertical: size.height * .05,
      horizontal: size.width * .09,
    );
  }
}
