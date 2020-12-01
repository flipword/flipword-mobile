import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/store/cards/card_list_store.dart';
import 'package:flutter_flip_card/ui/layouts/layout.dart';
import 'package:provider/provider.dart';
import 'ui/themes/theme.dart';



void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<CardListStore>(create: (_) => CardListStore(),)
        ],
        child: FutureBuilder(
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

            // Otherwise, show something whilst
            // waiting for initialization to complete
            return const CircularProgressIndicator();
          },
        ),
    );
  }
}
