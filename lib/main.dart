import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reminder_app/login_screen.dart';
import 'package:reminder_app/reminder_screen.dart';

late var box;

void main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('userdata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: box.get('isLogged', defaultValue: false) ? ReminderScreen() : HalamanLogin(),
    );
  }
}

