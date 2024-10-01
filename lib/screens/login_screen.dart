import 'dart:developer';

import 'package:flutter/material.dart';

//import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sky_2/providers/token_provider.dart';
import 'package:sky_2/providers/user_provider.dart';
import 'package:sky_2/screens/home_screen.dart';
import 'package:sky_2/services/auths.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: email,
          ),
          TextFormField(
            controller: pass,
          ),
          ElevatedButton(
              onPressed: () async {
                // isLoading = true;
                // setState(() {
                //
                // });
                try {
                  await AuthServices()
                      .loginUser(email: email.text, password: pass.text)
                      .then((loginResponse) async {
                    await AuthServices()
                        .userProfileData(loginResponse.token.toString())
                        .then((userResponse) {
                      Provider.of<UserProvider>(context, listen: false)
                          .setUser(userResponse);
                      Provider.of<TokenProvider>(context, listen: false)
                          .setToken(loginResponse.token.toString());
//print(userResponse.user!.name.toString());
                      isLoading = false;
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    });
                  });
                } catch (e) {
                  isLoading = false;
                  setState(() {});
                  log(e.toString());
                }
              },
              child: isLoading ? CircularProgressIndicator() : Text('Login'))
        ],
      ),
    );
  }
}
