import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_2/providers/task_desc_provider.dart';
import 'package:sky_2/providers/task_status_provder.dart';
import 'package:sky_2/providers/taskid_provider.dart';
import 'package:sky_2/providers/token_provider.dart';
import 'package:sky_2/providers/user_provider.dart';
import 'package:sky_2/screens/login_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => TokenProvider()),
    ChangeNotifierProvider(create: (context) => TaskIDProvider()),
    ChangeNotifierProvider(create: (context) => TaskDescProvider()),
    ChangeNotifierProvider(create: (context) => TaskStatusProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
