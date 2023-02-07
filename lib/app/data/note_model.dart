// ignore_for_file: body_might_complete_normally_nullable, prefer_collection_literals

class Note {
  int? id;
  String? title;
  String? desc;

  Note(this.title, this.desc);

  Note.fromJson(dynamic snapshot) {
    Map<String, dynamic>? json = snapshot.data() as Map<String, dynamic>?;
    id = snapshot.id;
    title = json?['title'];
    desc = json?['desc'];
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    return data;
  }

  void setNoteid(int id) {
    this.id = id;
  }
}
