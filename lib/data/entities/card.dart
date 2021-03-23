import 'package:flutter_flip_card/data/entities/word.dart';
import 'package:flutter_flip_card/services/language_service.dart';

class CardEntity {
  CardEntity(
      {this.nativeWord,
      this.foreignWord,
      this.nbSuccess = 0,
      this.nbErrors = 0});

  CardEntity.fromJson(Map<String, dynamic> json) {
    nativeWord = Word(
        word: json['nativeWord'] as String,
        languageId: 'fr');
    foreignWord = Word(
        word: json['foreignWord'] as String,
        languageId: 'en');
    nbSuccess = json['nbSuccess'] as int;
    nbErrors = json['nbErrors'] as int;
  }

  final LanguageService _languageService = LanguageService.instance;

  String id;
  Word nativeWord;
  Word foreignWord;
  int nbSuccess;
  int nbErrors;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nativeWord'] = nativeWord.word;
    data['foreignWord'] = foreignWord.word;
    data['nbSuccess'] = nbSuccess;
    data['nbErrors'] = nbErrors;
    data['id'] = id;
    return data;
  }
}
