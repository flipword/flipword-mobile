import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/data/entities/firebase_user_profil.dart';

import 'package:flutter_flip_card/services/auth_service.dart';
import 'package:flutter_flip_card/ui/widgets/words/card_word.dart';

class ProfileOnline extends StatelessWidget {
  ProfileOnline({Key key}) : super(key: key);

  UserProfil userProfil = AuthService.instance.getUser();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 90,
            backgroundImage: userProfil.fileImage,
          ),
          Container(
              padding: const EdgeInsets.all(20),
              child: Text('email : ${userProfil.email}',
                  style: const TextStyle(fontSize: 20))),
          Container(
              padding: const EdgeInsets.all(20),
              child: Text('name : ${userProfil.name}',
                  style: const TextStyle(fontSize: 20))),
          CardWord(nativeWord: 'learned word', foreignWord: '0')
        ],
      ),
    );
  }
}
