import 'package:language_pickers/languages.dart';
import 'package:language_pickers/utils/utils.dart';

import 'auth_service.dart';

class LanguageService {
  LanguageService._privateConstructor();

  Language nativeLanguage = LanguagePickerUtils.getLanguageByIsoCode('fr');
  Language foreignLanguage = LanguagePickerUtils.getLanguageByIsoCode('fr');

  static final LanguageService _instance = LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  String  getRef()  => '${nativeLanguage.isoCode}-${foreignLanguage.isoCode}';

}
