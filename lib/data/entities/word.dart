class Word {
  String word;
  String languageId;
  Word({this.word, this.languageId});

  Word.fromJson(Map<String, dynamic> json) {
    word = json['$word'];
    languageId = json['$languageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['$word'] = this.word;
    data['$languageId'] = this.languageId;
    return data;
  }
}