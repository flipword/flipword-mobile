import 'package:flutter/material.dart';
import 'package:flutter_flip_card/const/colors.dart';

// ignore: avoid_classes_with_only_static_members
class LightTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final base = ThemeData.light();

    return base.copyWith(
      accentColor: secondaryColor,
      accentColorBrightness: Brightness.dark,

      primaryColor: primaryColor,
      primaryColorBrightness: Brightness.dark,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: const TextTheme(
        bodyText2: TextStyle(
          color: blackColor,
        ),
      ),
      bottomAppBarColor: navBarColor,
      scaffoldBackgroundColor: background,
      cardColor: cardColor,
      backgroundColor: background,
      iconTheme: base.iconTheme.copyWith(
        color: blackColor
      ),
      appBarTheme: base.appBarTheme.copyWith(
        color: transparent,
        elevation: 0
      )
    );
  }
}