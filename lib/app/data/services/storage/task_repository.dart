import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/data/providers/task_provider/taskprovider.dart';

class TaskRepository{
  TaskProvider taskProvider = TaskProvider();
  TaskRepository({required this.taskProvider});
  List<TaskModel> readTask() => taskProvider.readTask();
  void writeTask(List<TaskModel> tasks) => taskProvider.writeTask(tasks);
  
}