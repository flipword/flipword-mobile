import 'package:flutter_flip_card/data/entities/word.dart';

class Card {
  Word nativeWord;
  Word foreignWord;
  int score;

  Card({this.nativeWord, this.foreignWord, this.score = 0});

  Card.fromJson(Map<String, dynamic> json) {
    nativeWord = json['nativeWord'];
    foreignWord = json['foreignWord'];
    score = json['$score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nativeWord'] = this.nativeWord.word;
    data['foreignWord'] = this.foreignWord.word;
    data['score'] = this.score;
    return data;
  }
}