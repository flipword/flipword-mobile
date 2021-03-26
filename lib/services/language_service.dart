import 'package:flutter_flip_card/data/entities/language.dart';

class LanguageService {
  LanguageService._privateConstructor();

  Language nativeLanguage = Language(isoCode: 'fr', label: 'French');
  Language foreignLanguage = Language(isoCode: 'en', label: 'English');

  static final LanguageService _instance = LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  String getRef() => '${nativeLanguage.isoCode}-${foreignLanguage.isoCode}';
}
