import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  const HomePage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home',
        style: new TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25.0
        ),
      ),
    );
  }
}
