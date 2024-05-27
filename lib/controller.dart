import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_complete/clrconst.dart';
// import 'package:noteapp/core/constants/clrconst.dart';

class NoteScreenController{
  static List noteslist = [];
   static var box = Hive.box('recent');

static List<Color> colorlist= [
  Clrs.blue,
  Clrs.green,
  Clrs.red,
  Clrs.yellow
];
 static  List noteKeys = [];

static getinitkeys(){
  noteslist = box.keys.toList().reversed.toList();
  // reverselist = box.keys.toList();
}

// static void addnote(
//   {
//     required String title,required String desc, required String date,int clrindex = 0,
//   }
// ){
//   noteslist.add({
// "title":title,
// "description":desc,
// "date":date,
// "color": clrindex,
//   });
// }
//  static void deletenote(var key){
//   box.delete(key);
//   noteKeys= box.keys.toList();
// }
static void editnote({required int index,
required String title,
required String desc,
 required String date,
 int clrindex = 0,}){
  noteslist[index] = {"title":title,
"description":desc,
"date":date,
"color": clrindex,};
}

}