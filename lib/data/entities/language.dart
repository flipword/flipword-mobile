class Language {
  Language({this.isoCode, this.label, this.flagPath});

  Language.fromJson(Map<String, dynamic> json) {
    isoCode = json['isoCode'];
    label = json['label'];
    flagPath = json['flagPath'];
  }

  String isoCode;
  String label;
  String flagPath;
}