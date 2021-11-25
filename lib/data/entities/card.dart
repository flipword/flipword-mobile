class CardEntity {
  CardEntity(
      {this.nativeWord,
      this.foreignWord,
      this.nbSuccess = 0,
      this.nbErrors = 0});

  CardEntity.fromJson(Map<String, dynamic> json) {
    nativeWord = json['nativeWord'];
    foreignWord = json['foreignWord'];
    nbSuccess = json['nbSuccess'];
    nbErrors = json['nbErrors'];
  }

  String? id;
  String? nativeWord;
  String? foreignWord;
  int? nbSuccess;
  int? nbErrors;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nativeWord'] = nativeWord;
    data['foreignWord'] = foreignWord;
    data['nbSuccess'] = nbSuccess;
    data['nbErrors'] = nbErrors;
    data['id'] = id;
    return data;
  }
}
