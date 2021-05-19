import 'package:flutter/material.dart';

const kSwatchPrimary = Color(0xFF0D0A80);
const kSwatchSecondary = Color(0xFFA3A0F8);
const kSwatchWhite = Colors.white;

const double kDividerThickness = 0.3;
const double kFontSizeHeadline3 = 25;
const double kBorderWidth = 2;

ThemeData buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: kSwatchPrimary,
    accentColor: kSwatchWhite,
    appBarTheme: AppBarTheme(
      backwardsCompatibility: false,
      foregroundColor: kSwatchPrimary,
      backgroundColor: kSwatchWhite,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: kSwatchWhite,
      contentTextStyle: TextStyle(
        color: kSwatchPrimary,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: kSwatchPrimary,
          width: kBorderWidth,
        ),
        borderRadius: BorderRadius.circular(kBorderWidth),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(kSwatchWhite),
        backgroundColor: MaterialStateProperty.all<Color>(kSwatchPrimary),
        textStyle: MaterialStateProperty.all<TextStyle>(
          _buildButtonTextStyle(),
        ),
      ),
    ),
    iconTheme: IconThemeData(
      color: kSwatchPrimary,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(kSwatchPrimary),
        backgroundColor: MaterialStateProperty.all<Color>(kSwatchWhite),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            width: kBorderWidth,
            color: kSwatchPrimary,
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          _buildButtonTextStyle(),
        ),
      ),
    ),
    primaryTextTheme: _buildTextThemeBase(base.primaryTextTheme),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all<Color>(
        kSwatchPrimary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(kSwatchPrimary),
        textStyle: MaterialStateProperty.all<TextStyle>(
          _buildButtonTextStyle().copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
    textTheme: _buildTextThemeBase(base.textTheme),
  );
}

TextStyle _buildButtonTextStyle() {
  return TextStyle(
    fontWeight: FontWeight.w500,
  );
}

TextTheme _buildTextThemeBase(TextTheme base) {
  return base
      .copyWith(
    headline3: base.headline3!.copyWith(
      fontWeight: FontWeight.w700,
    ),
  )
      .apply(
    bodyColor: kSwatchPrimary,
    displayColor: kSwatchPrimary,
    fontFamily: 'Roboto',
  );
}

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
  static EdgeInsets minWidthPad(BuildContext context) =>
      _paddingHorizontal(
        context: context,
        kHeightFactor: _kWidthHome,
      );

  //Display is 411 x 683
  //Vertical is 411 * _kWidth = 8.22
  //Horizontal is 683 * _kHeight = 27.32
  static EdgeInsets home(BuildContext context) =>
      _paddingSymmetric(
        context: context,
        kHeightFactor: _kHeightHome,
        kWidthFactor: _kWidthHome,
      );

  //Display is 411 x 683
  //Vertical is 411 * .02 = 8.22
  //Horizontal is 683 * .04 = 27.32
  ///Returns symmetric [EdgeInsets]
  static EdgeInsets contents(BuildContext context) =>
      _paddingSymmetric(
        context: context,
        kHeightFactor: _kHeightGame,
        kWidthFactor: _kWidthGame,
      );

  static EdgeInsets _paddingSymmetric({
    required BuildContext context,
    required double kWidthFactor,
    required double kHeightFactor,
  }) {
    final size = MediaQuery
        .of(context)
        .size;
    final vertical = size.height * kHeightFactor;
    final horizontal = size.width * kWidthFactor;

    return EdgeInsets.symmetric(
      vertical: vertical,
      horizontal: horizontal,
    );
  }

  static EdgeInsets _paddingHorizontal({
    required BuildContext context,
    required double kHeightFactor,
  }) {
    final size = MediaQuery
        .of(context)
        .size;
    final horizontal = size.height * kHeightFactor;

    return EdgeInsets.symmetric(
      horizontal: horizontal,
    );
  }
}
