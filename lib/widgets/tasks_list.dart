import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/task_tile.dart';
import 'dart:ui' as ui;

final LocalStorage localStorage = LocalStorage('toDoList.json');

bool initialised = false;
List tasksList = [];
String theme;

class TasksList extends StatelessWidget {
  Future<bool> get getData async {
    await localStorage.ready;

    if (localStorage != null) {
      theme = await localStorage.getItem('theme');

      tasksList = await localStorage.getItem('todos');
      print(theme);
      print(tasksList);
      if (tasksList == null) {
        tasksList = [
          Task(title: 'Hi there, this call a task'),
          Task(title: 'Create Task: Click the lightning bolt to add a task'),
          Task(title: 'Edit Task: Hold your created task then there will be a pop up window so you can change things'),
          Task(title: 'Delete Task: Swipe to delete task'),
          Task(title: 'Notification: You will have a notification when it hits due time'),
          Task(title: 'App Dark Mode: Go to Setting and play with that SwitchListTile'),
        ].map((e) => e.toJson()).toList();
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData,
      builder: (context, snapshot) {
        print(snapshot);
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Consumer<TaskData>(
            builder: (context, taskData, child) {
              if (!initialised) {
                if (theme == 'dark') {
                  taskData.toggleTheme();
                }
                taskData.init(tasksList);
                initialised = true;
              }
              print(taskData.tasks);

              if (taskData.tasks.length == 0) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top:100),
                        child: Text(
                          'Hey Hey! You are all free...',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top:50),
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/empty_list.gif'),
                              fit: BoxFit.fill,
                            ),
                          ),

                      )
                    ]
                  )

                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final task = taskData.tasks[index];
                  return Dismissible(
                    key: UniqueKey(),
                    dismissThresholds: {
                      DismissDirection.startToEnd: 0.6,
                      DismissDirection.endToStart: 0.6,
                    },
                    onDismissed: (direction) {
                      taskData.deleteTask(task);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('A task was removed'),
                        action: SnackBarAction(
                            label: 'UNDO?',
                            onPressed: () {
                              taskData.addTask(task, index: index);
                            }),
                      ));
                    },
                    background: Container(
                      color: Colors.deepOrange,
                      padding: EdgeInsets.only(left: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      padding: EdgeInsets.only(right: 20.0),
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    child: TaskTile(
                      index: index,
                      title: task.title,
                      isChecked: task.isChecked,
                      callback: (newValue) {
                        taskData.toggleCheck(task);
                      },
                    ),
                  );
                },
                itemCount: taskData.tasks.length,
              );
            },
          );
        }
      },
    );
  }
}
