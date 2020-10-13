import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/firebase_auth_provider.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children: [
              Text(
                'Profile',
                style: new TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25.0
                ),
              ),
              FlatButton(
                textTheme: Theme.of(context).buttonTheme.textTheme,
                color: Theme.of(context).primaryColor,
                onPressed: () { Login(); },
                child: null,
              )
        ])
      ),
    );
  }

  void Login(){
    signInWithGoogle();
  }
}
