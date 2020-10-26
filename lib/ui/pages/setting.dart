import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);
  static const String routeName = '/setting';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text(
              'Setting',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25.0
              ),
            )
        )
    );
  }
}
