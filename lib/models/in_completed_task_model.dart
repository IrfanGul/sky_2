// To parse this JSON data, do
//
//     final inCompleteTaskModel = inCompleteTaskModelFromJson(jsonString);

import 'dart:convert';

InCompleteTaskModel inCompleteTaskModelFromJson(String str) =>
    InCompleteTaskModel.fromJson(json.decode(str));

String inCompleteTaskModelToJson(InCompleteTaskModel data) =>
    json.encode(data.toJson());

class InCompleteTaskModel {
  List<Task>? tasks;
  int? count;
  String? message;
  bool? status;

  InCompleteTaskModel({
    this.tasks,
    this.count,
    this.message,
    this.status,
  });

  factory InCompleteTaskModel.fromJson(Map<String, dynamic> json) =>
      InCompleteTaskModel(
        tasks: json["tasks"] == null
            ? []
            : List<Task>.from(json["tasks"]!.map((x) => Task.fromJson(x))),
        count: json["count"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "tasks": tasks == null
            ? []
            : List<dynamic>.from(tasks!.map((x) => x.toJson())),
        "count": count,
        "message": message,
        "status": status,
      };
}

class Task {
  String? id;
  String? description;
  bool? complete;
  String? owner;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Task({
    this.id,
    this.description,
    this.complete,
    this.owner,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        description: json["description"],
        complete: json["complete"],
        owner: json["owner"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "description": description,
        "complete": complete,
        "owner": owner,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
