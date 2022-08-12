import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:to_do_list_app/app/core/values/color.dart';
import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';
import 'package:to_do_list_app/app/widgets/icons.dart';

class TaskCard extends StatefulWidget {
  HomeController controller = Get.find<HomeController>();
  TaskModel task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  Map<String, Icon> iconList = ToDoIcons.taskIcons();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: Get.height /4.4,
        width: Get.width / 2,
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0,4),
              blurRadius: 2,
              spreadRadius: 2
            ),
          
          ],
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             widget.task.toDoItems != null && widget.task.toDoItems!.isNotEmpty ? StepProgressIndicator(
              totalSteps: widget.task.toDoItems!.length,
              currentStep:0,
              padding: 0,
              selectedColor: ToDoColor.iconColors[widget.task.color]!,
              unselectedColor: Colors.white,
              ): const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: iconList[widget.task.icon],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top:50),
              child: Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title ,overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),),
                  const SizedBox(height: 10,),
                  Text("Total Tasks ${widget.task.toDoItems?.length ?? 0}",style: const TextStyle(color: Colors.black38, fontWeight: FontWeight.w500, fontSize: 15),),
                ],
              ),
            )
          ],
        ),
      );
  }
}