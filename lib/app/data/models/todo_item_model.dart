import 'package:flutter/material.dart';

class ToDoModel{
  String title;
  String timeofday;
  bool done;
  ToDoModel ({required this.title, required this.timeofday, this.done = false});

  factory ToDoModel.fromJson(Map<String,dynamic> data){
    return ToDoModel(title: data['title'], timeofday: data['timeofday'], done: data['done']);
  }

   Map<String, dynamic> toJson() {
    return {
      "title": title,
      "timeofday" : timeofday,
      "done": done
    };
  }
}