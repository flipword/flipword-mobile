import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/pages/add_word.dart';
import 'package:flutter_flip_card/ui/pages/list_word.dart';
import 'package:flutter_flip_card/ui/pages/profile.dart';

class Router {
  static const routes = {
    0 : ListWordPage.routeName,
    1 : ProfilePage.routeName,
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ListWordPage.routeName:
        return MaterialPageRoute(builder: (_) => ListWordPage());
      case AddWordPage.routeName:
        return MaterialPageRoute(builder: (_) => AddWordPage());
      case ProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        return MaterialPageRoute(builder: (_) => ListWordPage());
    }
  }
}