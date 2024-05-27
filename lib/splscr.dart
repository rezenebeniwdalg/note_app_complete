import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app_complete/notescr.dart';


class SplashScr extends StatefulWidget {
  const SplashScr({super.key});

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotesScreen()),
      );
    });
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/notes-svgrepo-com.svg",width: 300,),
         
          Text("Note it",style: TextStyle(color: Color.fromARGB(255,28,39,76),fontWeight: FontWeight.w900,fontSize: 30,),),
        ],
      ),),
    );
  }
}