import 'package:equatable/equatable.dart';
import 'package:to_do_list_app/app/data/models/todo_item_model.dart';

class TaskModel extends Equatable {
  final String title;
  final String icon;
  final String color;
  final List<dynamic>? toDoItems;
  const TaskModel(
      {required this.title,
      required this.icon,
      required this.color,
      this.toDoItems});

  TaskModel copywith({
    String? title,
    String? icon,
    String? color,
    List<dynamic>? toDoItems,
  }) {
    return TaskModel(
        title: title ?? this.title,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        toDoItems: toDoItems ?? this.toDoItems);
  }

  factory TaskModel.fromjson(Map<String, dynamic> data) {
    return TaskModel(
        title: data['title'],
        icon: data['icon'],
        color: data['color'],
        toDoItems: data['toDoItems']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "icon": icon,
      "color": color,
      "toDoItems": toDoItems
    };
  }

  @override
  List<Object?> get props => [title, icon, color];
}
