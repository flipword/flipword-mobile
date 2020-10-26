
class LanguageService {

  LanguageService._privateConstructor();

  var nativeLanguage = Language(id:'fr', label: 'Français');
  var foreignLanguage = Language(id:'en', label: 'Anglais');

  static final LanguageService _instance = LanguageService
      ._privateConstructor();
  static LanguageService get instance => _instance;

}

class Language {
  Language({this.id, this.label});

  final String id;
  final String label;
}