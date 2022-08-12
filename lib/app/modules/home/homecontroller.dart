import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/app/core/utils/type.dart';
import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/data/models/todo_item_model.dart';
import 'package:to_do_list_app/app/data/services/storage/task_repository.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  late final RxList<TaskModel> tasks;
  List<dynamic>? todos = [];
  final RxString type = personal.obs;
  final RxBool deleting = false.obs;
  final RxInt index = 0.obs;
  var task = Rx<TaskModel?>(null);
  RxList todoitem = <dynamic>[].obs;
  RxList todoDone = <dynamic>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<FormState> taskkey = GlobalKey();

  FocusNode taskF = FocusNode();
  FocusNode taskNameF = FocusNode();

  TextEditingController taskController = TextEditingController();
  TextEditingController taskNameC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    tasks = taskRepository.readTask().obs;
    print(tasks);
    ever(tasks, (_) => taskRepository.writeTask(tasks));
  }

  void iconTypeChange(String type) {
    this.type.value = type;
  }

  bool addTask(TaskModel task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  bool deleteTask({TaskModel? task, bool? delete}) {
    deleting.value = delete ?? false;
    if (task != null) {
      tasks.remove(task);
    }
    return deleting.value;
  }

  void deleteSpecificTask(int index, bool done){
    final dynamic deleteItem;
    if (done == false){
       deleteItem = todoitem[index];
    }
    else{
      deleteItem = todoDone[index];
    }
    task.value!.toDoItems!.remove(deleteItem);
    todoitem.remove(todoitem[index]);
    tasks[this.index.value] = task.value!;
  }

  void taskSelect({required TaskModel item, int? index}) {
    task.value = item;
    this.index.value = index ?? 0;
  }

  bool updateTask(TaskModel task, ToDoModel todoModel) {
    if (checkDublicate(tasks[index.value], todoModel.title) == true) {
      return false;
    } else {
      todos = task.toDoItems ?? [];
      //todos = this.task.value!.toDoItems ?? [];
      todos?.add(todoModel.toJson());
      TaskModel newTask = task.copywith(toDoItems: todos);
      todoitem.add(todoModel.toJson());
      todos = [];
      tasks[index.value] = newTask;
      return true;
    }
  }

  bool checkDublicate(TaskModel task, String title) {
    bool result = false;
    if (task.toDoItems != null) {
      task.toDoItems!.map((e) {
        e['title'] == title ? result = true : result = false;
      });
    }
    return result;
  }

  void todoListDefine() {
    if (task.value!.toDoItems != null) {
      todoDone.clear();
      todoitem.clear();
      for (var todo in task.value!.toDoItems!) {
        if (todo['done'] == true) {
          todoDone.add(todo);
        } else {
          todoitem.add(todo);
        }
      }
    }
  }

  void todoDoneCheck(int index){
    Map<String,dynamic> todo = todoitem[index];
    int taskIndex = task.value!.toDoItems!.indexOf(todo);
    todoitem.remove(todo);
    todo['done'] = true;
    todoDone.add(todo);
    task.value!.toDoItems![taskIndex] = todo;
    tasks[this.index.value] = task.value!;
  }
}
