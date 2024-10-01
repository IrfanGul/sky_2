import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_2/providers/task_desc_provider.dart';
import 'package:sky_2/providers/taskid_provider.dart';
import 'package:sky_2/providers/token_provider.dart';
import 'package:sky_2/screens/update_task_screen.dart';
import 'package:sky_2/services/task_services.dart';

import '../models/task_model.dart';

class ShowTasks extends StatefulWidget {
  const ShowTasks({super.key});

  @override
  State<ShowTasks> createState() => _ShowTasksState();
}

class _ShowTasksState extends State<ShowTasks> {
  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    var taskProvider = Provider.of<TaskIDProvider>(context);
    var taskDescription = Provider.of<TaskDescProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Get All Task"),
        ),
        body: FutureProvider.value(
          value:
              TaskServices().getAllTasks(tokenProvider.getToken().toString()),
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
                        leading: IconButton(
                          onPressed: () {
                            taskProvider
                                .setToken(taskModel.tasks![i].id.toString());
                            taskDescription.setDescription(
                                taskModel.tasks![i].description.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateTaskScreen()));
                          },
                          icon: Icon(Icons.edit),
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              try {
                                await TaskServices()
                                    .deleteTaskID(
                                        TaskID:
                                            taskModel.tasks![i].id.toString(),
                                        token:
                                            tokenProvider.getToken().toString())
                                    .then((onValue) {
                                  if (onValue == true) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Task Deleted'),
                                          );
                                        });
                                    setState(() {});
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Some Error Occured'),
                                          );
                                        });
                                  }
                                });
                              } catch (e) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(e.toString()),
                                      );
                                    });
                                // rethrow;
                              }
                            },
                            icon: Icon(Icons.delete)),
                        title: Text(taskModel.tasks![i].description.toString()),
                      );
                    });
          },
        ));
  }
}
