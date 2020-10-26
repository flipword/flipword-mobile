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
    User user =  firebaseAuthService.getUser();
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
                      return new Text('$status');
                    } else {
                      return new Text('problemme');
                    }
                  }else{
                    return CircularProgressIndicator();
                }}
              )
            ),
              RaisedButton(
                textTheme: Theme.of(context).buttonTheme.textTheme,
                color: Theme.of(context).primaryColor,
                onPressed: () { login(); },
                child: Text('Login'),
              ),
              RaisedButton(
                textTheme: Theme.of(context).buttonTheme.textTheme,
                color: Theme.of(context).primaryColor,
                onPressed: () { logout(); },
                child: Text('Logout'),
              ),
        ])
      ),
    );
  }

  void logout(){
    firebaseAuthService.logout().then((value) => this.setState(() {
      checkStatus().then((value) => status = value);
    }));

  }

  void login(){
    firebaseAuthService.signInWithGoogle().then((value) => this.setState(() {
      checkStatus().then( (value) =>  status = value
      );
    }));
  }
}
