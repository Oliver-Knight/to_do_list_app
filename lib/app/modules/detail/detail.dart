import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:to_do_list_app/app/core/utils/extensions.dart';
import 'package:to_do_list_app/app/core/values/color.dart';
import 'package:to_do_list_app/app/data/models/todo_item_model.dart';
import 'package:to_do_list_app/app/modules/detail/widgets/todo_listtile.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';
import 'package:to_do_list_app/app/widgets/icons.dart';

class DetailPage extends StatefulWidget {
  HomeController controller = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TimeOfDay initialTime = TimeOfDay.now();
  TimeOfDay? timeOfDay;
  Map<String, dynamic> iconList = ToDoIcons.taskIcons();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  splashRadius: 20,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                iconList[widget.controller.task.value.icon],
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.controller.task.value.title,
                  style: TextStyle(
                    fontSize: 16.5.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 20,
            ),
            if (widget.controller.task.value.toDoItems!.isEmpty) ...[
              SizedBox(
                height: Get.height / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Lottie.asset('images/70032-task-on-clipboard-2.json'),
                    Form(
                      key: widget.controller.taskkey,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //todo
                          Get.defaultDialog<Widget>(
                              title: "Add Task",
                              titlePadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              content: dialogContent(),
                              cancel: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text("Cancel")),
                              confirm: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ToDoColor.iconColors[widget
                                                  .controller
                                                  .task
                                                  .value
                                                  .icon])),
                                  onPressed: () {
                                    if (widget.controller.taskkey.currentState!
                                            .validate() ==
                                        true) {
                                      bool result = widget.controller.updateTask(
                                          widget.controller.task.value,
                                          ToDoModel(
                                              title: widget
                                                  .controller.taskNameC.text,
                                              timeofday: timeOfDay != null
                                            ? "${timeOfDay!.hour} : ${timeOfDay!.minute}"
                                            : "${initialTime.hour} : ${initialTime.minute}"));
                                      Get.back();
                                      setState(() {
                                        widget.controller.todoListDefine();
                                      });
                                      widget.controller.taskNameC.clear();
                                      if (result) {
                                        EasyLoading.showSuccess(
                                            "Success uploated");
                                      } else {
                                        EasyLoading.showError(
                                            "Dublicate Error");
                                      }
                                    }
                                  },
                                  child: const Text("Confirm")));
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                ToDoColor.iconColors[
                                    widget.controller.task.value.icon])),
                        icon: const Icon(
                          Icons.add_task,
                        ),
                        label: const Text("Add Task"),
                      ),
                    )
                  ],
                ),
              )
            ] else ...[
              Obx(() {
                int totalTask = widget.controller.todoitem.length +
                    widget.controller.todoDone.length;
                int completeTask = widget.controller.todoDone.length;
                return Row(
                  children: [
                    Text("Total Task ($totalTask)",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: StepProgressIndicator(
                            unselectedSize: 4,
                            selectedSize: 5.5,
                            totalSteps: totalTask > 0 ? totalTask : 1,
                            currentStep: completeTask,
                            padding: 0,
                            selectedColor: ToDoColor.iconColors[
                                widget.controller.task.value.icon]!,
                            unselectedColor: Colors.black12),
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Obx(() => ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...widget.controller.todoitem
                          .map((todo) => ToDoListTile(
                                todo: todo,
                                color: widget.controller.task.value.icon,
                                slidableKey:
                                    widget.controller.todoitem.indexOf(todo),
                              ))
                          .toList()
                    ],
                  )),
              const Divider(
                color: Colors.grey,
                height: 40,
                thickness: 1,
              ),
              Obx(() => ListView(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Text(
                        "Complete (${widget.controller.todoDone.length})",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                      ...widget.controller.todoDone
                          .map((todo) => ToDoListTile(
                                todo: todo,
                                color: widget.controller.task.value.icon,
                                slidableKey:
                                    widget.controller.todoitem.indexOf(todo),
                              ))
                          .toList()
                    ],
                  )),
            ]
          ],
        ),
      ),
      floatingActionButton: widget.controller.task.value.toDoItems == null
          ? null
          : widget.controller.task.value.toDoItems!.isEmpty
              ? null
              : Form(
                  key: widget.controller.taskkey,
                  child: FloatingActionButton(
                    backgroundColor: ToDoColor
                        .iconColors[widget.controller.task.value.icon],
                    onPressed: () {
                      //todo
                      Get.defaultDialog(
                          title: "Add Task",
                          titlePadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          content: dialogContent(),
                          cancel: TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Cancel")),
                          confirm: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ToDoColor.iconColors[
                                          widget.controller.task.value.icon])),
                              onPressed: () {
                                if (widget.controller.taskkey.currentState!
                                        .validate() ==
                                    true) {
                                  bool result = widget.controller.updateTask(
                                      widget.controller.task.value,
                                      ToDoModel(
                                          title:
                                              widget.controller.taskNameC.text,
                                          timeofday: timeOfDay != null
                                            ? "${timeOfDay!.hour} : ${timeOfDay!.minute}"
                                            : "${initialTime.hour} : ${initialTime.minute}"));
                                  Get.back();
                                  widget.controller.todoListDefine();
                                  widget.controller.taskNameC.clear();
                                  if (result) {
                                    EasyLoading.showSuccess("Success uploated");
                                  } else {
                                    EasyLoading.showError("Dublicate Error");
                                  }
                                }
                              },
                              child: const Text("Confirm")));
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
    );
  }

  Widget dialogContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller.taskNameC,
          focusNode: widget.controller.taskNameF,
          onEditingComplete: () {
            widget.controller.taskNameF.unfocus();
          },
          validator: (value) => widget.controller.taskNameC.text.isEmpty
              ? "You need to fill your task!"
              :widget.controller.taskNameC.text.startsWith(" ")
              ? "Task name cannot start with 'SPACE'!"
              : null,
          decoration: const InputDecoration(
              isDense: true, border: OutlineInputBorder()),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Choose Time",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: Get.width,
          height: 50,
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
      ],
    );
  }
}
