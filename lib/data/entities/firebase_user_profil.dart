class FirebaseUserProfil {

  FirebaseUserProfil( {this.email, this.name, this.lastConnection});

  FirebaseUserProfil.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    lastConnection = json['lastConnection'];
  }

  String email;
  String name;
  String lastConnection;
  bool isConnecter;
  String uid;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['lastConnection'] = lastConnection;
    return data;
  }
}
