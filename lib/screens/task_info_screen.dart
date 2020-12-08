import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/screens/task_edit_screen.dart';
import 'package:todoey/widgets/option_button.dart';
import 'dart:ui' as ui;

import '../constants.dart';

class TaskInfoScreen extends StatelessWidget {
  TaskInfoScreen({this.task, this.index});

  final Task task;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/edit_task.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Icon(
                  FontAwesomeIcons.arrowAltCircleLeft,
                  color: Colors.white,
                  size: 40.0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 30.0,
                  right: 30.0,
                  bottom: 10.0,
                ),
                child: Text(
                  'Task Infor',
                  style: TextStyle(
                    fontFamily: "EastSeaDokdo",
                    fontSize: 80.0,
                    foreground: Paint()
                      ..shader = ui.Gradient.linear(
                          const Offset(0, 20),
                          const Offset(150, 60),
                          <Color>[
                            Colors.yellow,
                            Colors.purple,
                          ]),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 30.0,
                      right: 30.0,
                      bottom: 30.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Task Title: ${task.title}',
                          style: kTaskInfoTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Task is done: ${task.isChecked}',
                          style: kTaskInfoTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Task Reminder: ${task.reminderDate != null ? task.reminderDate.toString() : "Not set"}',
                          style: kTaskInfoTextStyle,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              OptionButton(
                                title:
                                    'Mark ${task.isChecked ? 'Inc' : 'C'}omplete',
                                onPressed: () {
                                  Provider.of<TaskData>(
                                    context,
                                    listen: false,
                                  ).toggleCheck(task);
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: 20.0),
                              OptionButton(
                                  title: 'Edit Task',
                                  onPressed: () async {
                                    await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return TaskEditScreen(task: task);
                                    }));
                                    Navigator.pop(context);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
