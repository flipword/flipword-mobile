import 'package:flutter/material.dart';
import 'package:flutter_flip_card/const/colors.dart';

class MyTheme {
  static final ThemeData defaultTheme = _buildTheme();

  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: SecondaryColor,
      accentColorBrightness: Brightness.dark,

      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      primaryColorBrightness: Brightness.dark,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      bottomAppBarColor: NavBarColor,
      scaffoldBackgroundColor: Background,
      cardColor: Background,
      textSelectionColor: PrimaryColorLight,
      backgroundColor: Background,
      iconTheme: base.iconTheme.copyWith(
        color: IconColor
      )
    );
  }
}