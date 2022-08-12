import 'dart:convert';
import 'package:get/get.dart';
import 'package:to_do_list_app/app/core/utils/keys.dart';
import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/data/models/todo_item_model.dart';
import 'package:to_do_list_app/app/data/services/storage/services.dart';

class TaskProvider {
  final StorageSerivce _storage = Get.find<StorageSerivce>();

  List<TaskModel> readTask() {
    List<TaskModel> tasks = [];
    dynamic value = jsonDecode(_storage.read(Storage.textKey).toString());
    for (var i in value) {
      tasks.add(TaskModel.fromjson(i));
    }
    return tasks;
  }

  void writeTask(List<TaskModel> tasks) {
    _storage.write(Storage.textKey,
        List<dynamic>.from(tasks.map((e) => jsonEncode(e.toJson()))));
  }
}
