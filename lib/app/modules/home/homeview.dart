import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/app/core/utils/type.dart';
import 'package:to_do_list_app/app/core/values/color.dart';
import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/modules/detail/detail.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';
import 'package:to_do_list_app/app/core/utils/extensions.dart';
import 'package:to_do_list_app/app/modules/home/widgets/new_test_card.dart';
import 'package:to_do_list_app/app/modules/home/widgets/task_add.dart';
import 'package:to_do_list_app/app/modules/home/widgets/task_card.dart';
import 'package:to_do_list_app/app/modules/report/report.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.0.wp, vertical: 2.0.hp),
                  child: Text(
                    "My Task List",
                    style: TextStyle(
                        fontSize: 22.0.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(() => GridView.count(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      crossAxisCount: 2,
                      children: [
                        ...controller.tasks
                            .map((task) => LongPressDraggable(
                                  data: task,
                                  onDragStarted: () =>
                                      controller.deleteTask(delete: true),
                                  onDraggableCanceled: (_, __) =>
                                      controller.deleteTask(delete: false),
                                  onDragCompleted: () =>
                                      controller.deleteTask(delete: false),
                                  feedback: Opacity(
                                      opacity: .5, child: TaskCard(task: task)),
                                  child: InkWell(
                                      onTap: () {
                                        controller.taskSelect(item: task, index: controller.tasks.indexOf(task));
                                        controller.todoListDefine();  
                                        Get.to(DetailPage(),
                                            transition: Transition.zoom);
                                      },
                                      onDoubleTap: () => Get.defaultDialog(
                                          title: "Alert",
                                          content: const Text(
                                            "Do you want to delete this task?",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          confirm: ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          ToDoColor.iconColors[
                                                              task.color]!)),
                                              onPressed: () {
                                                Get.back();
                                                controller.deleteTask(
                                                    task: task);
                                                EasyLoading.showSuccess(
                                                    "Successfully deleted");
                                              },
                                              child: const Text("Confirm")),
                                          cancel: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("Cancel"))),
                                      child: TaskCard(task: task,)),
                                ))
                            .toList(),
                        const NewTestCard(),
                      ],
                    ))
              ],
            ),
            floatingActionButton: DragTarget<TaskModel>(
              onAccept: (TaskModel? task) => controller.deleteTask(task: task),
              builder: (_, __, ___) {
                return Obx(
                  () => FloatingActionButton(
                    elevation: 30,
                    backgroundColor: controller.deleting.value
                        ? Colors.redAccent
                        : ToDoColor.iconColors[shop],
                    onPressed: () {
                      controller.taskNameC.clear();
                      controller.task.value = TaskModel(title: '', icon: '', color: '');
                      Get.to(const AddTask(), transition: Transition.zoom);
                    },
                    tooltip: "Add Task",
                    child: controller.deleting.value
                        ? const Icon(Icons.delete)
                        : const Icon(Icons.add),
                  ),
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(const ReportScreen(),transition: Transition.zoom);
                        },
                        icon: const Icon(Icons.menu),
                        splashRadius: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.settings),
                      splashRadius: 20,
                    )
                  ],
                ),
              ),
            )));
  }
}
