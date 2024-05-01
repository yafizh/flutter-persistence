class Note {
  final int? id;
  final String title;
  final String desc;

  Note({this.id, required this.title, required this.desc});

  Map<String, String> toMap() {
    return {'title': title, 'desc': desc};
  }
}
