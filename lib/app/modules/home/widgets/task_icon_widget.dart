import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';

class TaskIcon extends StatelessWidget {
  final HomeController _controller = Get.find<HomeController>();
  Icon icon;
  String label;
  RxString? type;
  TaskIcon({Key? key, required this.icon, required this.label, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      onTap: () => _controller.iconTypeChange(label),
      child: Obx(() => Container(
        padding: const EdgeInsets.all(5),
        decoration:  BoxDecoration(
          color: type?.value == label ? Colors.blue[200] : null,
          borderRadius: const BorderRadius.all(Radius.circular(8))
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
            Text(label)
          ],
        ),
      ),
    ));
  }
}
