import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todonhut/models/task_data.dart';
import 'package:todonhut/screens/add_task_screen.dart';
import 'package:todonhut/screens/app_info_screen.dart';
import 'package:todonhut/screens/settings_screen.dart';
import 'package:todonhut/screens/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings();
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(ChangeNotifierProvider<TaskData>(
    create: (_) => TaskData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      theme: Provider.of<TaskData>(context).currTheme,
      title: 'NhutToDo',
      initialRoute: TasksScreen.id,
      routes: {
        TasksScreen.id: (context) => TasksScreen(),
        AddTaskScreen.id: (context) => AddTaskScreen(),
        AppInfoScreen.id: (context) => AppInfoScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
      },
    );
  }
}