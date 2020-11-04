
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_robohash_repository.dart';

import 'package:flutter_flip_card/services/auth_service.dart';

class ProfileOnline extends StatelessWidget {

  ProfileOnline({Key key}) : super(key: key);
  static RobohashHelper robohashHelper = RobohashHelper.instance;
  static AuthService firebaseAuthService = AuthService.instance;

  String email ;

  @override
  Widget build(BuildContext context) {
    email = firebaseAuthService.getUser().email;
    return Column(
      children: [
        FutureBuilder(
            future:  robohashHelper.getAvatare(email),
            builder: (BuildContext context, AsyncSnapshot<FileImage> snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              return  CircleAvatar(
                radius: 90,
                backgroundImage: snapshot.data,
              );
            }else {
              return const CircularProgressIndicator();
            }}),
        Container(
            padding: const EdgeInsets.all(20),
            child: Text(
                email,
                style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30
                )
            )
        ),
      ],
    );
  }
}
