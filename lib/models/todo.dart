class Todo {
  int _id;
  String _title;
  bool _complete;

  Todo(this._id, this._title, this._complete);

  bool get complete => _complete;

  String get title => _title;

  int get id => _id;

  factory Todo.fromJson(dynamic json) {
    int id = json['id']??0;
    String title = json['title']??"";
    bool completed = json['completed']??false;
    return Todo(id, title, completed);
  }
}