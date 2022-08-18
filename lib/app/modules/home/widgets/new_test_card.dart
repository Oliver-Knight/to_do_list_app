import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/app/core/utils/type.dart';
import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';
import 'package:to_do_list_app/app/modules/home/widgets/task_icon_widget.dart';
import 'package:to_do_list_app/app/widgets/icons.dart';

class NewTestCard extends StatefulWidget {
  const NewTestCard({Key? key}) : super(key: key);

  @override
  State<NewTestCard> createState() => _NewTestCardState();
}

class _NewTestCardState extends State<NewTestCard> {
  final HomeController controller = Get.find<HomeController>();
  Map<String, Icon> iconList = ToDoIcons.taskIcons();
  @override
  void dispose() {
    super.dispose();
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width / 2,
      height: Get.height / 2,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          controller.taskController.clear();
          controller.type.value = personal;
          Get.dialog(AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    controller.taskController.clear();
                    controller.type.value = personal;
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  splashRadius: 15,
                  color: Colors.grey,
                ),
                TextButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate() == true) {
                        TaskModel task = TaskModel(
                            title: controller.taskController.text,
                            icon: controller.type.value,
                            color: controller.type.value);
                        controller.addTask(task)
                            ? EasyLoading.showSuccess(
                                "Create Task Successfully")
                            : EasyLoading.showError("Dublicate Task");
                        Navigator.pop(context);
                      }

                      controller.type.value = personal;
                      controller.taskController.clear();
                    },
                    child: const Text("Done"))
              ],
            ),
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(15),
            content: SizedBox(
              height: Get.height / 2,
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "New Task List",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onEditingComplete: () {
                          if (controller.formKey.currentState!.validate() ==
                              true) {
                            TaskModel task = TaskModel(
                                title: controller.taskController.text,
                                icon: controller.type.value,
                                color: controller.type.value);
                            controller.addTask(task)
                                ? EasyLoading.showSuccess(
                                    "Create Task List Successfully")
                                : EasyLoading.showError("Dublicate Task");
                            Navigator.pop(context);
                          }

                          controller.type.value = personal;
                          controller.taskController.clear();
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.taskController,
                        focusNode: controller.taskF,
                        validator: (e) {
                          if (controller.taskController.text == '') {
                            return "You need to fill the Task title!";
                          }
                          if (controller.taskController.text.startsWith(' ')) {
                            return "Task List cannot start with 'SPACE'!";
                          }
                          if(controller.taskController.text.length > 30){
                            return "Title count must less than 30 characters";
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                        decoration: const InputDecoration(
                            border:  OutlineInputBorder(),
                            labelText: "Task List Name",
                            labelStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Task List Type",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TaskIcon(
                        icon: iconList[personal]!,
                        label: personal,
                        type: controller.type,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TaskIcon(
                          icon: iconList[work]!,
                          label: work,
                          type: controller.type),
                      const SizedBox(
                        height: 10,
                      ),
                      TaskIcon(
                          icon: iconList[movie]!,
                          label: movie,
                          type: controller.type),
                      const SizedBox(
                        height: 10,
                      ),
                      TaskIcon(
                          icon: iconList[sport]!,
                          label: sport,
                          type: controller.type),
                      const SizedBox(
                        height: 10,
                      ),
                      TaskIcon(
                          icon: iconList[travel]!,
                          label: travel,
                          type: controller.type),
                      const SizedBox(
                        height: 10,
                      ),
                      TaskIcon(
                          icon: iconList[shop]!,
                          label: shop,
                          type: controller.type),
                      TaskIcon(
                          icon: iconList[game]!,
                          label: game,
                          type: controller.type)
                    ],
                  ),
                ),
              ),
            ),
          ));
          // showDialog(
          //     context: context,
          //     builder: (context) {
          //       return ;
          //     });
        },
        child: DottedBorder(
            dashPattern: const [8, 6],
            color: Colors.black45,
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
