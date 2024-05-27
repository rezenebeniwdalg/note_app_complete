import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_complete/splscr.dart';
// import 'package:noteapp/view/splscr/splscr.dart';

Future<void> main()async{
  await Hive.initFlutter();
 var box = Hive.openBox('recent');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScr(),
    );
  }
}