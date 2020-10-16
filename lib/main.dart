import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/layout.dart';
import 'package:flutter_flip_card/ui/themes/theme.dart';

void main() {
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlipWord',
        theme: MyTheme.defaultTheme,
        home: Layout()
    );
  }
}
