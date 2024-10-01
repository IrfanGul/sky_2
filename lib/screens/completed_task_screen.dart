import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_2/models/task_model.dart';
import 'package:sky_2/providers/token_provider.dart';
import 'package:sky_2/services/task_services.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks List'),
        centerTitle: true,
      ),
      body: FutureProvider.value(
          value: TaskServices()
              .completedTasks(tokenProvider.getToken().toString()),
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
