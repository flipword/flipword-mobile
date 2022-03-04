import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfil {
  UserProfil({this.email, this.name, this.lastConnection, this.nbWordLearned});

  UserProfil.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    name = json['name'];
    lastConnection = json['lastConnection'];
    nbWordLearned = json['nbWordLearned'] ?? 0;
    nativeLanguageIsoCode = json['nativeLanguageIsoCode'];
    foreignLanguageIsoCode = json['foreignLanguageIsoCode'];
    nbWordLearned = json['nbWordLearned'] ?? 0;
    nbSuccessRequired = json['nbSuccessRequired'] ?? 5; // 5 is default number of success required
    hasDidMainOnBoarding = json['hasDidMainOnBoarding'] ?? false;
    hasDidAddingOnBoarding = json['hasDidAddingOnBoarding'] ?? false;
  }

  String? email;
  String? name;
  Timestamp? lastConnection;
  late bool isConnected;
  late bool hasDidMainOnBoarding;
  late bool hasDidAddingOnBoarding;
  String? uid;
  String? avatarPath;
  int? nbWordLearned;
  int? nbSuccessRequired;
  String? nativeLanguageIsoCode;
  String? foreignLanguageIsoCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['lastConnection'] = lastConnection;
    data['nbWordLearned'] = nbWordLearned;
    data['nbSuccessRequired'] = nbSuccessRequired;
    data['nativeLanguageIsoCode'] = nativeLanguageIsoCode;
    data['foreignLanguageIsoCode'] = foreignLanguageIsoCode;
    data['hasDidMainOnBoarding'] = hasDidMainOnBoarding;
    data['hasDidAddingOnBoarding'] = hasDidAddingOnBoarding;
    return data;
  }
}
