class Credential {
  int? id;
  String? servicename;
  String? username;
  String? password;

  Credential({this.id, this.servicename, this.username, this.password});

  Credential.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    servicename = json['servicename'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['servicename'] = servicename;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
