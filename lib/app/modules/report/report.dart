import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:to_do_list_app/app/core/utils/type.dart';
import 'package:to_do_list_app/app/core/values/color.dart';
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
    double result = controller.taskDone();
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              splashRadius: 20,
            ),
            SfCircularChart(
              title: ChartTitle(
                  text: "Task Report",
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black54)),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CircularSeries>[
                PieSeries<TaskModel, String>(
                  dataSource: controller.tasks,
                  xValueMapper: (TaskModel task, _) => task.title,
                  yValueMapper: (TaskModel task, _) =>
                      task.toDoItems?.length ?? 0,
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      showCumulativeValues: true,
                      showZeroValue: false),
                  enableTooltip: true,
                )
              ],
            ),
           const Center(
              child:  Text("Task Detailt", style: TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54)),
            ),
            const SizedBox(height: 40,),
            Center(
              child: TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: result),
                duration: const Duration(seconds: 1),
                builder:(context, double value, child) {
                  int percent = (value*100).toInt();
                  return SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return SweepGradient(
                            stops: [value,value],
                            colors: [ToDoColor.iconColors[shop]!, Colors.black12])
                              .createShader(rect);
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: 160,
                          height: 160,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                          ),
                          child: Text("$percent %", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black54),),
                        ),
                      )
                    ],
                  ),
                );
                },
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: ToDoColor.iconColors[shop],
                      shape: BoxShape.circle,
                      
                    ),
                  
                  ),
                  const SizedBox(width: 10,),
                  const Text("Complete Tasks")
                ],),
                Row(
                  
                  children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      
                    ),
                  
                  ),
                  const SizedBox(width: 10,),
                  const Text("Remain Tasks")
                ],),
              ],
            )
          ],
        ),
      ),
    );
  }
}
