import 'package:flutter/material.dart';
import 'package:sky_2/models/task_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TaskModel? taskModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search from site'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextFormField(),
        ],
      ),
    );
  }
}
