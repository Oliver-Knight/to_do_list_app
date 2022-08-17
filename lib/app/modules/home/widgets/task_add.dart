import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/app/core/utils/type.dart';
import 'package:to_do_list_app/app/core/values/color.dart';
import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/data/models/todo_item_model.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_app/app/widgets/icons.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final HomeController controller = Get.find<HomeController>();
  Map<String, Icon> iconList = ToDoIcons.taskIcons();
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? timeOfDay;
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Form(
            key: controller.taskkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                    controller.taskNameC.clear();
                    controller.task.value = TaskModel(title: '', icon: '', color: '');
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  splashRadius: 20,
                ),
                const Text(
                  "Add New Task",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.taskNameC,
                  focusNode: controller.taskNameF,
                  onEditingComplete: () {
                    controller.taskNameF.unfocus();
                  },
                  validator: (value) => controller.taskNameC.text == ''
                      ? "You need to fill your task!"
                      : null,
                  decoration: const InputDecoration(
                      hintText: "Task...", border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Choose Time",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.width,
                  height: 60,
                  child: OutlinedButton(
                    onPressed: () async {
                      timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: initialTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeOfDay != null && timeOfDay != initialTime) {
                        setState(() {
                          initialTime = timeOfDay!;
                        });
                      }
                    },
                    child: Text(
                      "${initialTime.hour}:${initialTime.minute}",
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add to",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: controller.tasks.length,
                      itemBuilder: (context, index) {
                        return Obx(() => ListTile(
                              onTap: () {
                                controller.taskSelect(
                                    item: controller.tasks[index],
                                    index: index);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              dense: true,
                              // selected: controller.task.value ==
                              //         controller.tasks[index]
                              //     ? true
                              //     : false,
                              // selectedTileColor: Colors.black26,
                              // selectedColor:
                              //     const Color.fromARGB(255, 255, 255, 255),
                              leading: iconList[controller.tasks[index].icon]!,
                              trailing: controller.task.value ==
                                      controller.tasks[index]
                                  ? const Icon(Icons.done)
                                  : null,
                              title: Text(
                                controller.tasks[index].title,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(controller.tasks[index].color),
                            ));
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      width: 200,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ToDoColor.iconColors[shop])),
                          onPressed: () {
                            if (controller.taskkey.currentState!.validate() ==
                                true) {
                              if (controller.task.value == null) {
                                EasyLoading.showError(
                                    "Please choose  Task List");
                              } else {
                                bool result = controller.updateTask(
                                    controller.task.value,
                                    ToDoModel(
                                        title: controller.taskNameC.text,
                                        timeofday: timeOfDay != null
                                            ? "${timeOfDay!.hour} : ${timeOfDay!.minute}"
                                            : "${initialTime.hour} : ${initialTime.minute}"));
                                Get.back();
                                controller.taskNameC.clear();
                                controller.task.value = const TaskModel(title: '', icon: '', color: '');
                                if (result) {
                                  EasyLoading.showSuccess("Success uploated");
                                } else {
                                  EasyLoading.showError("Dublicate Error");
                                }
                              }
                            }
                          },
                          child: const Text("Add")),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
