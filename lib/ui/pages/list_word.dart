import 'package:flutter/material.dart';

class ListWordPage extends StatelessWidget {
  static const String routeName = '/list';

  const ListWordPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'List word',
          style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25.0
          ),
        ),
      ),
    );
  }
}
