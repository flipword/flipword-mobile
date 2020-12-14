import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home',
          style:  TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25
          ),
        )
      )
    );
  }
}
