class Secret {
  Secret({this.keyId, this.value});

  Secret.fromJson(Map<String, dynamic> json) {
    keyId = json['keyId'];
    value = json['value'];
  }

  String? keyId;
  String? value;
}