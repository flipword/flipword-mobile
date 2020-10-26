import 'package:flutter/material.dart';

class LanguageService {

  var nativeLanguage = Language(id:'fr', label: 'Français');
  var foreignLanguage = Language(id:'en', label: 'Anglais');

  LanguageService._privateConstructor();

  static final LanguageService _instance = LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  String  getRef()  => nativeLanguage.id+foreignLanguage.id;

}

class Language {
  Language({this.id, this.label});

  final String id;
  final String label;
}