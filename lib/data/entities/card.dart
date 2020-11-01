import 'package:flutter_flip_card/data/entities/word.dart';
import 'package:flutter_flip_card/services/language_service.dart';

class Card {
  final LanguageService _languageService = LanguageService.instance;

  Card({this.nativeWord, this.foreignWord, this.score = 0});

  Card.fromJson(Map<String, dynamic> json) {
    nativeWord = Word(word: json['nativeWord'] as String, languageId: _languageService.nativeLanguage.id);
    foreignWord = Word(word: json['foreignWord'] as String, languageId: _languageService.foreignLanguage.id);
    score = json['score'] as int;
  }

  Word nativeWord;
  Word foreignWord;
  int score;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nativeWord'] = nativeWord.word;
    data['foreignWord'] = foreignWord.word;
    data['score'] = score;
    return data;
  }
}