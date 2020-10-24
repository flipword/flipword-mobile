class Word {
  String langue1;
  String langue2;
  String word1;
  String word2;
  int score = 0;

  Word({this.langue1, this.langue2, this.word1,this.word2,this.score});

  Word.fromJson(Map<String, dynamic> json) {
    langue1 = json['$langue1'];
    langue2 = json['$langue2'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$langue1'] = this.word1;
    data['$langue2'] = this.word2;
    data['score'] = this.score;
    return data;
  }
}