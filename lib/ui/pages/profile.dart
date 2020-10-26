import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/service/firebaseServices/firebase_auth_service.dart';


class ProfilePage extends StatefulWidget  {
  static const String routeName = '/profile';
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>{


  static FirebaseAuthService firebaseAuthService = FirebaseAuthService.instance;
  String status;
  String effect;

  Future<String> checkStatus() async {
    final User user =  firebaseAuthService.getUser();
    if( user != null){
      return user.uid;
    }
    return  'non co';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children:  <Widget> [
            Container(
              child: FutureBuilder(
                future: checkStatus(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasData){
                      status = snapshot.data;
                      return Text('$status');
                    } else {
                      return const Text('problemme');
                    }
                  }else{
                    return const CircularProgressIndicator();
                }}
              )
            ),
              RaisedButton(
                textTheme: Theme.of(context).buttonTheme.textTheme,
                color: Theme.of(context).primaryColor,
                onPressed: () { login(); },
                child: const Text('Login'),
              ),
              RaisedButton(
                textTheme: Theme.of(context).buttonTheme.textTheme,
                color: Theme.of(context).primaryColor,
                onPressed: () { logout(); },
                child: const Text('logout'),
              ),
        ])
      ),
    );
  }

  void logout(){
    firebaseAuthService.logout().then((value) => setState(() {
      checkStatus().then((value) => status = value);
    }));

  }

  void login(){
    firebaseAuthService.signInWithGoogle().then((value) => setState(() {
      checkStatus().then( (value) =>  status = value
      );
    }));
  }
}
