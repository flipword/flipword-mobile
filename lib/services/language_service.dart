

import 'auth_service.dart';

class LanguageService {
  LanguageService._privateConstructor();

  // Language nativeLanguage = LanguagePickerUtils.getLanguageByIsoCode('fr');
  // Language foreignLanguage = LanguagePickerUtils.getLanguageByIsoCode('en');

  static final LanguageService _instance = LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  String  getRef()  => '';

}
