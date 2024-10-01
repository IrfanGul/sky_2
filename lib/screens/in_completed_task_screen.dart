import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import 'package:sky_2/models/in_completed_task_model.dart';
import 'package:sky_2/providers/token_provider.dart';

import '../models/task_model.dart';
import '../services/task_services.dart';

class InCompletedTaskScreen extends StatefulWidget {
  const InCompletedTaskScreen({super.key});

  @override
  State<InCompletedTaskScreen> createState() => _InCompletedTaskScreenState();
}

class _InCompletedTaskScreenState extends State<InCompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('In Completed Tasks List'),
        centerTitle: true,
      ),
      body: FutureProvider.value(
          value: TaskServices()
              .inCompletedTasks(tokenProvider.getToken().toString()),
          initialData: TaskModel(),
          builder: (context, child) {
            TaskModel taskModel = context.watch<TaskModel>();
            return taskModel.tasks == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: taskModel.tasks!.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(taskModel.tasks![i].description.toString()),
                      );
                    });
          }),
    );
  }
}
