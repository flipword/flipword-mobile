import 'package:flutter/material.dart';
import 'package:flutter_flip_card/const/colors.dart';

class MyTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: secondaryColor,
      accentColorBrightness: Brightness.dark,

      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,
      primaryColorBrightness: Brightness.dark,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      bottomAppBarColor: navBarColor,
      scaffoldBackgroundColor: background,
      cardColor: cardColor,
      textSelectionColor: primaryColorLight,
      backgroundColor: background,
      iconTheme: base.iconTheme.copyWith(
        color: iconColor
      ),
      appBarTheme: base.appBarTheme.copyWith(
        color: transparent,
        elevation: 0
      )
    );
  }
}