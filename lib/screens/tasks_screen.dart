import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/screens/add_task_screen.dart';
import 'package:todoey/screens/app_info_screen.dart';
import 'package:todoey/screens/settings_screen.dart';
import 'package:todoey/widgets/tasks_list.dart' hide localStorage;
import 'package:todoey/models/task_data.dart';
import 'dart:ui' as ui;

class TasksScreen extends StatelessWidget {
  static String id = 'tasksScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(top: 40.0),
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pushNamed(context, AppInfoScreen.id);
                },
              ),

              // Deleted ListTile for How to use because it does not make any sense

              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, SettingsScreen.id);
                },
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(),
              ),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.bolt),
      ),
      body: FutureBuilder(
        future: localStorage.ready,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 60.0,
                    left: 30.0,
                    right: 30.0,
                    bottom: 30.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: Scaffold.of(context).openDrawer,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.list,
                            size: 30.0,
                            color: Colors.lightBlueAccent,
                          ),
                          radius: 30.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "ToDoNhut",
                            style: TextStyle(
                              fontSize: 62.5,
                              fontFamily: "EastSeaDokdo",
                              fontWeight: FontWeight.w700,
                              foreground: Paint()
                                ..shader = ui.Gradient.linear(
                                    const Offset(0, 20),
                                    const Offset(150, 60),
                                    <Color>[
                                      Colors.yellow,
                                      Colors.redAccent,
                                    ]),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left:10),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/icon/icon.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${Provider.of<TaskData>(context).tasks.length} tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: TasksList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
