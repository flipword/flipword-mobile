import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Profile',
          style: new TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25.0
          ),
        ),
      ),
    );
  }
}
