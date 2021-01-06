import 'package:flutter/cupertino.dart';
import 'package:flutter_flip_card/services/language_service.dart';
import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';

class UserProfil {
  UserProfil({this.email, this.name, this.lastConnection, this.nbWordLearned});

  UserProfil.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    lastConnection = json['lastConnection'];
    nbWordLearned = json['nbWordLearned'];

  }

  String email;
  String name;
  String lastConnection;
  bool isConnecter;
  String uid;
  FileImage fileImage;
  int nbWordLearned;


  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['lastConnection'] = lastConnection;
    data['nbWordLearned'] = nbWordLearned;
    return data;
  }
}
