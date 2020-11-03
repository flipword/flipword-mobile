class LanguageService {
  LanguageService._privateConstructor();

  Language nativeLanguage = Language(id:'fr', label: 'Français');
  Language foreignLanguage = Language(id:'en', label: 'Anglais');

  static final LanguageService _instance = LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  String  getRef()  => '${nativeLanguage.id}-${foreignLanguage.id}';

}

class Language {
  Language({this.id, this.label});

  final String id;
  final String label;
}