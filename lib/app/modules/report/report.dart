import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:to_do_list_app/app/data/models/task_model.dart';
import 'package:to_do_list_app/app/modules/home/homecontroller.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios_new_outlined), splashRadius: 20,),
            SfCircularChart(
              title: ChartTitle(text: "Task Report", textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries>[
                PieSeries<TaskModel, String>(
                  dataSource: controller.tasks,
                  xValueMapper: (TaskModel task, _) => task.title,
                  yValueMapper: (TaskModel task,_) => task.toDoItems?.length ?? 0,
                  dataLabelSettings: const DataLabelSettings(isVisible: true, showCumulativeValues: true,showZeroValue: false),
                  enableTooltip: true,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}