import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  static const String routeName = '/setting';

  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Text(
              'Setting',
              style: new TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0
              ),
            )
        )
    );
  }
}
