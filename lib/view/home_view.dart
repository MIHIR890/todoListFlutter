import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/models/tasks_model.dart';
import 'package:todo_list_app/view/login_view.dart';
import 'package:todo_list_app/view_model/authentication_view_model.dart';
import 'package:todo_list_app/view_model/task_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      final taskVM = Provider.of<TaskViewModel>(context, listen: false);
      taskVM.clearTasks();
      taskVM.fetchTasks();
    });

    super.initState();


  }


  @override
  Widget build(BuildContext context) {

    final taskVM = Provider.of<TaskViewModel>(context);

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        title: const Text("My Tasks",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.indigo,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.white,),
            onPressed: () async {

              await Provider.of<AuthViewModel>(
                context,
                listen: false,
              ).logout();
              Provider.of<TaskViewModel>(
                context,
                listen: false,
              ).clearTasks();
            },
          )
        ],
      ),

      body: Column(
        children: [

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: controller,

                    decoration: InputDecoration(
                      hintText: "Enter new task...",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.indigo),
                    onPressed: () {
                      if(controller.text.isNotEmpty){
                        taskVM.addTask(controller.text);
                        controller.clear();
                      }
                    },
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: taskVM.taskLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : taskVM.tasks.isEmpty
                ? const Center(
              child: Text(
                "No Tasks Yet",
                style: TextStyle(fontSize: 18),
              ),
            )
                :
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),

                itemCount: taskVM.tasks.length,

                itemBuilder: (context, index) {

                  Task task = taskVM.tasks[index];

                  return Card(
                    color: Colors.yellow.shade100,
                    elevation: 3,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(10),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Checkbox(
                                value: task.completed,
                                activeColor: Colors.indigo,
                                onChanged: (_) {
                                  taskVM.toggleTask(task);
                                },
                              ),

                              Row(
                                children: [

                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 20),
                                    onPressed: () {
                                      showEditDialog(task);
                                    },
                                  ),

                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 20),
                                    onPressed: () {
                                      taskVM.deleteTask(task.id);
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),

                          const SizedBox(height: 5),

                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration:
                              task.completed ? TextDecoration.lineThrough : null,
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          )
        ],
      ),
    );
  }

  void showEditDialog(Task task) {

    final controller = TextEditingController(text: task.title);

    showDialog(
        context: context,

        builder: (_) {
          return AlertDialog(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),

            title: const Text("Edit Task"),

            content: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Update task",
              ),
            ),

            actions: [

              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),

                child: const Text("Update"),

                onPressed: () {

                  task.title = controller.text;

                  Provider.of<TaskViewModel>(context, listen: false)
                      .toggleTask(task);

                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}