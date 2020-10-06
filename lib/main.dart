import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/pages/add_word.dart';
import 'package:flutter_flip_card/ui/pages/home.dart';
import 'package:flutter_flip_card/ui/pages/list_word.dart';
import 'package:flutter_flip_card/ui/pages/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder> {
        HomePage.routeName: (BuildContext context) => const HomePage(),
        ListWordPage.routeName : (BuildContext context) => const ListWordPage(),
        AddWordPage.routeName : (BuildContext context) => const AddWordPage(),
        ProfilePage.routeName : (BuildContext context) => const ProfilePage()
      },
    );
  }
}
