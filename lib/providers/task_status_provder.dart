import 'package:flutter/material.dart';

class TaskStatusProvider extends ChangeNotifier {
  bool? _status;

  void setStatus(bool status) {
    _status = status;
    notifyListeners();
  }

  bool? getStatus() => _status;
}
