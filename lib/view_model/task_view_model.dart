import 'package:flutter/material.dart';
import 'package:todo_list_app/models/tasks_model.dart';
import 'package:todo_list_app/repository/task_repo.dart';

class TaskViewModel extends ChangeNotifier {

  final TaskRepository _repo = TaskRepository();

  List<Task> tasks = [];

  var taskLoading = false;

  Future fetchTasks() async {
    taskLoading =true;
    tasks = await _repo.fetchTasks();
    taskLoading = false;
    notifyListeners();
  }

  Future addTask(String title) async {

    Task task = Task(
      id: "",
      title: title,
      completed: false,
    );

    await _repo.addTask(task);

    await fetchTasks();
  }

  Future deleteTask(String id) async {

    await _repo.deleteTask(id);

    tasks.removeWhere((t) => t.id == id);

    notifyListeners();
  }

  Future toggleTask(Task task) async {

    task.completed = !task.completed;

    await _repo.updateTask(task);

    notifyListeners();
  }
  void clearTasks(){
    tasks.clear();
    notifyListeners();
  }
}