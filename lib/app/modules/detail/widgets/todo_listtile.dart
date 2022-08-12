import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/app/core/values/color.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';

class ToDoListTile extends StatefulWidget {
  final dynamic todo;
  final String color;
  final int slidableKey;
  const ToDoListTile(
      {Key? key,
      required this.todo,
      required this.color,
      required this.slidableKey})
      : super(key: key);

  @override
  State<ToDoListTile> createState() => _ToDoListTileState();
}

class _ToDoListTileState extends State<ToDoListTile> {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    Map<String, Color> colorList = ToDoColor.iconColors;
    return AbsorbPointer(
      absorbing: widget.todo['done'] ? true : false,
      child: Slidable(
        // key: ValueKey(widget.slidableKey),
        endActionPane: ActionPane(motion: const ScrollMotion(),
            // dismissible: DismissiblePane(onDismissed: () {
            //   controller.deleteSpecificTask(widget.slidableKey);
            // }),
            children: [
              SlidableAction(
                onPressed: (_) {
                  controller.deleteSpecificTask(widget.slidableKey,widget.todo['done']);
                  debugPrint(widget.slidableKey.toString());
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                icon: Icons.delete,
                label: 'Delete',
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            onLongPress: () {
              Get.defaultDialog(
                  title: "Alert",
                  content: const Text("Do you want to delete this Task?"),
                  confirm: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              colorList[widget.color])),
                      onPressed: () {
                        controller.deleteSpecificTask(widget.slidableKey, widget.todo['done']);
                        Get.back();
                      },
                      child: const Text("Sure")),
                  cancel: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Cancel")));
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            tileColor: const Color.fromARGB(59, 173, 169, 169),
            leading: IconButton(
              onPressed: () {
                controller.todoDoneCheck(widget.slidableKey);
              },
              icon: widget.todo['done']
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank),
              splashRadius: 20,
            ),
            title: widget.todo['done']
                ? Text(
                    widget.todo['title'],
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  )
                : Text(widget.todo['title']),
            trailing: Text(widget.todo['timeofday']),
          ),
        ),
      ),
    );
  }
}
