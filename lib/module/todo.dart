class ToDO {
  String? id;
  String? todText;
  late bool isDone;

  ToDO({
    required this.id,
    required this.todText,
    this.isDone = false,
  });

  static List<ToDO> todolist() {
    return [
      ToDO(id: '01', todText: 'Go to Uni', isDone: false),
      ToDO(id: '02', todText: 'Quiz', isDone: false),
      ToDO(id: '03', todText: 'Assignment', isDone: true),
      ToDO(id: '04', todText: 'Project', isDone: false),
    ];
  }
}
