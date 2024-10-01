import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:sky_2/configs/backend_configs.dart';
import 'package:sky_2/configs/end_points.dart';
//import 'package:sky_2/models/in_completed_task_model.dart';

import '../models/task_model.dart';

class TaskServices {
  Future<bool> createTask({required String desc, required String token}) async {
    var response = await http.post(
        Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kAddTask),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode({"description": desc}));
    log(response.request!.url.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<TaskModel> getAllTasks(String token) async {
    var response = await http.get(
      Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kGetAllTasks),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  Future<bool> deleteTaskID(
      {required String TaskID, required String token}) async {
    var respoonse = await http.delete(
      Uri.parse(
          BackendConfigs.kBaseUrl + '${EndPoints.kDeleteTaskID}/' + TaskID),
      headers: {'Authorization': token},
    );
    if (respoonse.statusCode == 200 || respoonse.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTask(
      {required String token,
      required String taskID,
      required String status,
      required String description}) async {
    var response = await http.patch(
        Uri.parse(
            '${BackendConfigs.kBaseUrl}${EndPoints.kUpdateTaskID}/$taskID'),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: jsonEncode({"description": description, "complete": status}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<TaskModel> completedTasks(String token) async {
    var response = await http.get(
      Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kGetCompletedTasks),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  Future<TaskModel> searchTask(
      {required String token, required String searchKey}) async {
    var response = await http.get(
      Uri.parse(BackendConfigs.kBaseUrl +
          '${EndPoints.kGetCompletedTasks}/?keywords=${searchKey}'),
      headers: {
        'Authorization': token,
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  Future<TaskModel> inCompletedTasks(String token) async {
    var response = await http.get(
      Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kGetInCompletedTasks),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(jsonDecode(response.body));
    } else {
      return TaskModel();
    }
  }

  Future<bool> updateTaskStatus(
      {required String token,
      required String ID,
      required String description,
      required bool status}) async {
    var response = await http.patch(
        Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kUpdateTaskStatus + ID),
        headers: {'Authorization': token, 'Content-Type': 'application/json'},
        body: (jsonEncode({"description": description, "complete": status})));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
