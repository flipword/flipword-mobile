import 'package:flutter/material.dart';
import 'package:flutter_flip_card/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  static AuthService firebaseAuthService = AuthService.instance;

  String userID;
  String effet;
  bool conection;

  Future<bool> checkStatus() async {
    final user = firebaseAuthService.getUser();
    userID = user.uid;
    if(user.isAnonymous){
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: checkStatus(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  conection = snapshot.data;
                  if(conection){
                    effet = 'Login';
                  } else {
                    effet = 'Logout';
                  }
                  return Column(
                    children: [
                      Text(userID),
                      RaisedButton(
                        textTheme: Theme.of(context).buttonTheme.textTheme,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if(conection){
                            login();
                          } else {
                            logout();
                          }
                        },
                        child: Text(effet),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }

  void logout() {
    firebaseAuthService.logout()
        .then((value) => checkStatus()
        .then((value) => setState(()=>{})) );
  }

  void login() {
    firebaseAuthService.signInWithGoogle()
        .then((value) => checkStatus()
        .then((value) => setState(()=>{})) );
  }
}
