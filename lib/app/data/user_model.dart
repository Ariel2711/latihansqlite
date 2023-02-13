// ignore_for_file: body_might_complete_normally_nullable, prefer_collection_literals

class User {
  int? id;
  String? username;
  String? password;
  String? role;

  User(this.username, this.password, this.role);

  User.fromJson(dynamic snapshot) {
    Map<String, dynamic>? json = snapshot.data() as Map<String, dynamic>?;
    id = snapshot.id;
    username = json?['username'];
    password = json?['password'];
    role = json?["role"];
  }

  User.fromJsonApi(dynamic snapshot) {
    Map<String, dynamic>? json = snapshot as Map<String, dynamic>?;
    id = json?['id'];
    username = json?['username'];
    password = json?['password'];
    role = json?["role"];
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['role'] = role;
    return data;
  }

  void setUserid(int id) {
    this.id = id;
  }
}
