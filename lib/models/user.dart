class User {
  late String? about;
  late int created;
  late int? delay;
  late String id;
  late int karma;
  late List<int> submitted;

  User.fromMap(Map data) {
    about = data['about'];
    created = data['created'];
    delay = data['delay'];
    id = data['id'];
    karma = data['karma'];
    submitted =
        data['submitted'] == null ? [] : List<int>.from(data['submitted']);
  }

  DateTime get exactTime => DateTime.fromMillisecondsSinceEpoch(created);
}
