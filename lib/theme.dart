import 'package:flutter/material.dart';

const kSwatchPrimary = Color(0xFF0D0A80);
const kSwatchSecondary = Color(0xFFA3A0F8);

const double kBorderWidth = 2;

ThemeData buildTheme() {
  final base = ThemeData.light();
  return base.copyWith(
    primaryColor: kSwatchPrimary,
    colorScheme: base.colorScheme.copyWith(
      secondary: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      foregroundColor: kSwatchPrimary,
      backgroundColor: Colors.white,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
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
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
