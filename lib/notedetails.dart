import 'package:flutter/material.dart';

class Notesdetails extends StatelessWidget {
  const Notesdetails({super.key,required this.title,required this.desc,required this.date,});
  final String title;
  final String desc;
  final String date;
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
         
          children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(title,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),),
                ),
              Container(child: Text(date),),
              ],
            ),
          ),
          Container(child: Text(desc),)
        ],),
      ),
    );
  }
}