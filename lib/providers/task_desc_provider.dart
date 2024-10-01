import 'package:flutter/cupertino.dart';

class TaskDescProvider extends ChangeNotifier {
  String? _desc;

  void setDescription(String description) {
    _desc = description;
    notifyListeners();
  }

  String? getDescription() => _desc;
}
