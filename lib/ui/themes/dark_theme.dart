import 'package:flutter/material.dart';
import 'package:flutter_flip_card/const/colors.dart';

// ignore: avoid_classes_with_only_static_members
class DarkTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final base = ThemeData.dark();

    return base.copyWith(
        accentColor: secondaryColor,
        accentColorBrightness: Brightness.dark,
        primaryColor: primaryColor,
        primaryColorBrightness: Brightness.dark,
        buttonTheme: base.buttonTheme.copyWith(
          buttonColor: secondaryColorDark,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: whiteColor,
          ),
        ),
        bottomAppBarColor: navBarColorDark,
        scaffoldBackgroundColor: backgroundDark,
        cardColor: cardColorDark,
        backgroundColor: backgroundDark,
        shadowColor: shadowColorDark,
        iconTheme: base.iconTheme.copyWith(color: blackColor),
        splashColor: secondaryColor,
        appBarTheme:
            base.appBarTheme.copyWith(color: transparent, elevation: 0),
        errorColor: negativeColor,
        indicatorColor: positiveColor);
  }
}
