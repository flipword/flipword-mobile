import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_robohash_repository.dart';
import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_offline.dart';
import 'package:flutter_flip_card/ui/widgets/profil/profil_online.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  static AuthService firebaseAuthService = AuthService.instance;
  static RobohashHelper robohashHelper = RobohashHelper.instance;

  String userName;
  FileImage image;
  bool conection;
  String effet;

  Future<bool> checkStatus() async {
    final user = firebaseAuthService.getUser();
    if (user.isAnonymous) {
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
                  if (conection) {
                    effet = 'Login';
                  } else {
                    effet = 'Logout';
                  }
                  return Column(
                    children: [
                      FutureBuilder(
                          future: checkStatus(),
                          builder: (BuildContext context,
                              AsyncSnapshot<bool> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              conection = snapshot.data;
                              if (conection) {
                                return ProfileOffline();
                              } else {
                                return ProfileOnline();
                              }
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                      RaisedButton(
                        textTheme: Theme.of(context).buttonTheme.textTheme,
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (conection) {
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
    firebaseAuthService
        .logout()
        .then((value) => checkStatus().then((value) => setState(() => {})));
  }

  void login() {
    firebaseAuthService
        .signInWithGoogle()
        .then((value) => checkStatus().then((value) => setState(() => {})));
  }
}
