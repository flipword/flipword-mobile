import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/pages/add_word.dart';
import 'package:flutter_flip_card/ui/pages/home.dart';
import 'package:flutter_flip_card/ui/pages/list_word.dart';
import 'package:flutter_flip_card/ui/pages/profile.dart';
import 'package:flutter_flip_card/ui/pages/setting.dart';

class RouterApp {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(builder: (_) => HomePage());
      case ListWordPage.routeName:
        return MaterialPageRoute(builder: (_) => ListWordPage());
      case SettingPage.routeName:
        return MaterialPageRoute(builder: (_) => SettingPage());
      case ProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case AddWordPage.routeName:
        return MaterialPageRoute(builder: (_) => AddWordPage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}