class Word {
  Word({this.id, this.fr, this.en});

  final int id;
  final String fr;
  final String en;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fr': fr,
      'en': en,
    };
  }
}