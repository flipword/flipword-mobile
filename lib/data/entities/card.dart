import 'package:flutter_flip_card/data/entities/word.dart';

class Card {
  Card({this.nativeWord, this.foreignWord, this.score = 0});

  Card.fromJson(Map<String, dynamic> json)
      : nativeWord = json['nativeWord'] as Word,
        foreignWord = json['foreignWord'] as Word,
        score = json['score'] as int;

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