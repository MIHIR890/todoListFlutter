import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todo_list_app/constants.dart';
import 'package:todo_list_app/models/tasks_model.dart';

class TaskRepository {


/// fetch tasks
  Future<List<Task>> fetchTasks() async {

    String? userId = FirebaseAuth.instance.currentUser?.uid;

    if(userId == null) return [];

    final response = await http.get(
        Uri.parse("${FirebaseConstants.baseUrl}/$userId.json"));

    final data = json.decode(response.body);

    List<Task> tasks = [];

    if (data != null && data is Map<String, dynamic>) {
      data.forEach((id, value) {
        tasks.add(Task.fromJson(id, value));
      });
    }

    return tasks;
  }

/// add new task
  Future addTask(Task task) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await http.post(
      Uri.parse("${FirebaseConstants.baseUrl}/$userId.json"),
      body: json.encode(task.toJson()),
    );
    if(kDebugMode){
      print("${FirebaseConstants.baseUrl}.json");
      print(task.toJson());
    }
  }
/// delete tasks
  Future deleteTask(String id) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await http.delete(
        Uri.parse("${FirebaseConstants.baseUrl}/$userId/$id.json"));
  }
  ///update task

  Future updateTask(Task task) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    await http.patch(
      Uri.parse("${FirebaseConstants.baseUrl}/$userId/${task.id}.json"),
      body: json.encode(task.toJson()),
    );
  }
}