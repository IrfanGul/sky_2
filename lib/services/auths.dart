import 'dart:convert';

//import 'dart:developer';
import 'package:sky_2/models/login_model.dart';
import 'package:sky_2/models/regster_model.dart';
import 'package:http/http.dart' as http;
import 'package:sky_2/models/user_profile_model.dart';

import '../configs/backend_configs.dart';
import '../configs/end_points.dart';

class AuthServices {
  Future<RegisterModel> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    var response = await http.post(
        Uri.parse(
          BackendConfigs.kBaseUrl + EndPoints.kRegisterUser,
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else {
      return RegisterModel();
    }
  }

  Future<LoginModel> loginUser(
      {required String email, required String password}) async {
    var response = await http.post(
        Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kLoginUser),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LoginModel.fromJson(jsonDecode(response.body));
    } else {
      return LoginModel();
    }
  }

  Future<UserProfileModel> userProfileData(String token) async {
    var response = await http.get(
        Uri.parse(BackendConfigs.kBaseUrl + EndPoints.kUserProfile),
        headers: {'Authorization': token});
    //log(response.request!.url.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserProfileModel.fromJson(jsonDecode(response.body));
    } else {
      return UserProfileModel();
    }
  }
}
