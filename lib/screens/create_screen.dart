import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_2/providers/token_provider.dart';
import 'package:sky_2/screens/completed_task_screen.dart';
import 'package:sky_2/screens/in_completed_task_screen.dart';
import 'package:sky_2/screens/search_screen.dart';
import 'package:sky_2/screens/show_tasks.dart';
import 'package:sky_2/services/task_services.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  TextEditingController descController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var token = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Task'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: descController,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  isLoading = true;
                  setState(() {});
                  if (descController.text.isEmpty) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('please enter dexscription'),
                    ));
                  } else {
                    await TaskServices()
                        .createTask(
                            desc: descController.text,
                            token: token.getToken().toString())
                        .then((val) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Task created'),
                            );
                          });
                      isLoading = false;
                      setState(() {});
                    });
                  }
                } catch (e) {
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: isLoading ? CircularProgressIndicator() : Text('Create')),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowTasks()));
              },
              child: Text('Show Tasks')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CompletedTaskScreen()));
              },
              child: Text('Show Completed Tasks')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InCompletedTaskScreen()));
              },
              child: Text('Show InCompleted Tasks')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              child: Text('Search Screen')),
        ],
      ),
    );
  }
}
