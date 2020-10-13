class Word {
  final int id;
  final String fr;
  final String en;

  Word({this.id, this.fr, this.en});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fr': fr,
      'en': en,
    };
  }
}