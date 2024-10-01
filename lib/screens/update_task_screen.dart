import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_2/providers/task_desc_provider.dart';
import 'package:sky_2/providers/task_status_provder.dart';
import 'package:sky_2/providers/taskid_provider.dart';
import 'package:sky_2/providers/token_provider.dart';
import 'package:sky_2/screens/show_tasks.dart';
import 'package:sky_2/services/task_services.dart';

class UpdateTaskScreen extends StatefulWidget {
  const UpdateTaskScreen({super.key});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  @override
  Widget build(BuildContext context) {
    var taskIDProvider = Provider.of<TaskIDProvider>(context);
    var tokenProvider = Provider.of<TokenProvider>(context);
    var taskDescription = Provider.of<TaskDescProvider>(context);
    var taskStatus = Provider.of<TaskStatusProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Update Task'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(taskDescription.getDescription().toString()),
              Switch(
                  value: taskStatus.getStatus() ?? false,
                  onChanged: (val) {
                    setState(() {
                      taskStatus.setStatus(val);
                    });
                  }),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      bool switchValue = taskStatus.getStatus() ?? false;
                      String Status = switchValue ? 'true' : 'false';
                      await TaskServices()
                          .updateTask(
                        description: 'testted task',
                        token: tokenProvider.getToken().toString(),
                        taskID: taskIDProvider.getToken().toString(),
                        status: Status,
                      )
                          .then((onValue) {
                        if (onValue == true) {
                          // showDialog(context: context, builder: (context){
                          //  return AlertDialog(
                          //    title: Text('Task Updated'),
                          //  );
                          //});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowTasks()));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('error'),
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
                    }
                  },
                  child: Text('update'))
            ],
          ),
        ));
  }
}
