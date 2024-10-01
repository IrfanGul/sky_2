import 'package:flutter/cupertino.dart';

//import 'package:provider/provider.dart';

class TokenProvider extends ChangeNotifier {
  String? _token;

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  String? getToken() => _token;
}
