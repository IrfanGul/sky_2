import 'package:sky_2/models/user_profile_model.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  UserProfileModel? _userModel;

  void setUser(UserProfileModel model) {
    _userModel = model;
    notifyListeners();
  }

  UserProfileModel? getUser() => _userModel;
}
