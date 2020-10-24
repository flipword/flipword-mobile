import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/ui/layouts/layout.dart';
import 'package:flutter_flip_card/ui/themes/theme.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';


void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return MaterialApp(
                title: 'FlipWord',
                theme: MyTheme.defaultTheme,
                home: Layout()
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return  MaterialApp(
                title: 'FlipWord',
                theme: MyTheme.defaultTheme,
                home: Layout()
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return CircularProgressIndicator();
        },



    );
  }
}
