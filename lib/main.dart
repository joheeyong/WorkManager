import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';



/// Used for Background Updates using Workmanager Plugin
@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );

  Workmanager().registerOneOffTask(
    "work.taskName",
    "work.taskName",
    initialDelay: const Duration(milliseconds: 1),
  );

  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    // One off task registration
    if(Platform.isAndroid) {
      Workmanager().registerOneOffTask(
          "oneoff-task-identifier",
          "simpleTask"
      );

// Periodic task registration
      Workmanager().registerPeriodicTask(
        "periodic-task-identifier",
        "simplePeriodicTask",
        // When no frequency is provided the default 15 minutes is set.
        // Minimum frequency is 15 min. Android will automatically change your frequency to 15 min if you have configured a lower frequency.
        frequency: Duration(hours: 1),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeWidget Example'),
      ),
      body: Container(),
    );
  }
}
