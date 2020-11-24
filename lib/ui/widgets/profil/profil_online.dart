import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/data_sources/firestore_data_source/firestore_user_profil_repository.dart';
import 'package:flutter_flip_card/data/data_sources/remote_data_source/dio_robohash_repository.dart';
import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';

import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';

class ProfileOnline extends StatelessWidget {
  ProfileOnline({Key key}) : super(key: key);
  static RobohashHelper robohashHelper = RobohashHelper.instance;
  static AuthService firebaseAuthService = AuthService.instance;
  FirestoreUserProfilRepository firestoreUserProfilRepository =
      FirestoreUserProfilRepository.instance;
  FirebaseUserProfil firebaseUserProfil;
  FileImage fileImage;

  Future<bool> futureBuild() async {
    await firestoreUserProfilRepository
        .getUserProfil()
        .then((value) => firebaseUserProfil = value);
    await robohashHelper
        .getAvatare(firebaseUserProfil.email)
        .then((value1) => fileImage = value1);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureBuild(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Card(
              margin: const EdgeInsets.all(20) ,
              child:  Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 90,
                    backgroundImage: fileImage,
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Text('email : ${firebaseUserProfil.email}',
                          style: const TextStyle(
                              fontSize: 20))),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Text('name : ${firebaseUserProfil.name}',
                          style: const TextStyle(
                              fontSize: 20))),
                  CardWord(nativeWord: 'learned word', foreignWord: '0')
                ],
              ),
            );

          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
