import 'package:flutter/cupertino.dart';

class TaskIDProvider extends ChangeNotifier {
  String? _taskID;

  void setToken(String taskID) {
    String? _taskID;
    _taskID = taskID;
    notifyListeners();
  }

  String? getToken() => _taskID;
}
