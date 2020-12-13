import 'package:flutter/cupertino.dart';

class UserProfil {

  UserProfil( {this.email, this.name, this.lastConnection});

  UserProfil.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    lastConnection = json['lastConnection'];
  }

  String email;
  String name;
  String lastConnection;
  bool isConnecter;
  String uid;
  FileImage fileImage;
  int learned_word;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['lastConnection'] = lastConnection;
    return data;
  }
}
