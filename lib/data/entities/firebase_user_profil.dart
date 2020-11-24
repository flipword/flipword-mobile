class FirebaseUserProfil {

  FirebaseUserProfil( {this.email, this.name});

  FirebaseUserProfil.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
  }

  String email;
  String name;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    return data;
  }
}
