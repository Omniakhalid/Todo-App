import 'package:intl/intl.dart';

class Todo{
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  String _dateString;

  set dateString(String value) {
    _dateString = value;
  }

  static const String collectionName = 'Tasks';
  Todo(this.id, this.title, this.description, this.dateTime, [this.isDone = false])
  :_dateString = DateFormat('dd/MM/yyyy').format(dateTime);

  Todo.fromJson(Map<String, Object?> json)
      : this(
      json['id']! as String,
      json['title']! as String,
      json['description']! as String,
      DateTime.fromMillisecondsSinceEpoch(json['dateTime']! as int),
      json['isDone']! as bool
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'dateString': _dateString,
      'isDone': isDone
    };
  }
}