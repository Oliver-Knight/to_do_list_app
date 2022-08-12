import 'package:get/get.dart';
import 'package:to_do_list_app/app/data/providers/task_provider/taskprovider.dart';
import 'package:to_do_list_app/app/data/services/storage/task_repository.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        taskRepository: TaskRepository(taskProvider: TaskProvider())));
  }
}
