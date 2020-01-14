///
/// project: code_brew
/// @package: models
/// @author dammyololade <damola@kobo360.com>
/// created on 2020-01-10
// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

import 'BaseModel.dart';

class Todo {
  int userId;
  int id;
  String title;
  bool completed;

  Todo({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    completed: json["completed"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "completed": completed,
  };
}

class TodoModel extends BaseModel<List> {

  // List<Todo> todoList;

  @override
  fromJson(List jsonArray) {
    data = List<Todo>.from(jsonArray.map((x) => Todo.fromJson(x)));
    return this;
  }

}
