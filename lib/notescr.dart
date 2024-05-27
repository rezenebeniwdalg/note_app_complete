
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:note_app_complete/controller.dart';
import 'package:note_app_complete/notecard.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
   NoteScreenController noteScreenController = NoteScreenController();
var box = Hive.box('recent');
  void addnote(
  {
    required String title,required String desc, required String date,int clrindex = 0,
  }
)async{
  await box.add({
"title":title,
"description":desc,
"date":date,
"color": clrindex,
  });
  setState(() {
    setState(() {
  NoteScreenController.noteslist = box.keys.toList().reversed.toList();
});
  });

}
void deletenote(var key)async{
  await box.delete(key);
  NoteScreenController.noteslist= box.keys.toList().reversed.toList();
}
  TextEditingController _title = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _date = TextEditingController();
  
  int slctdclrindex = 0;

@override
void initState(){
  NoteScreenController.getinitkeys();
  super.initState();
 var box = Hive.box('recent');
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black54,


      floatingActionButton: FloatingActionButton(onPressed: () {
        //  NoteScreenController.clearControllers();
      custombottomSheet(context: context);
      },
      child: Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index){
          final currentkey = NoteScreenController.noteslist[index];
            final currentelement =NoteScreenController.box.get(currentkey);
          return Notescard(


          
          title: currentelement["title"],
          desc:  currentelement["description"],
          date:  currentelement["date"],
          clrindex: currentelement["color"],
          onDelete: () {
            deletenote(NoteScreenController.noteslist[index]);
            setState(() {
              
            });
            
          },
          onEdit: () {
            custombottomSheet(context: context ,isedit: true,index: index);
            setState(() {
              
            });
          }
        );},
      separatorBuilder: (context,index)=>SizedBox(height: 10,),
      itemCount: NoteScreenController.noteslist.length,
      ),
    );
  }
  Future<dynamic> custombottomSheet({required BuildContext context, bool isedit = false,int? index}){
    return showModalBottomSheet(
          backgroundColor: Colors.amber,
          isScrollControlled: true,

          context: context, builder: (context)=> 
           StatefulBuilder(builder: (context, setState) {
              return Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Text("Add Note"),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _title,
                  decoration: InputDecoration(
                    hintText: "Title",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                ), SizedBox(height: 10,),
                  TextFormField(
                    controller: _desc,
                    maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Description",
                    filled: true,
                    
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                ), SizedBox(height: 10,),
                  TextFormField(
                    readOnly: true,
                    controller: _date,
                  decoration: InputDecoration(
                    hintText: "Date",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      
                    ),
                    suffixIcon: InkWell(onTap: ()async {
                     final slctddatetime= await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
                     if (slctddatetime != null) {
                       String formatedDate = DateFormat('dd/MM/yyyy').format(slctddatetime);
                       _date.text = formatedDate.toString();
                     }
                                         setState((){});
                    },child: Icon(Icons.date_range_rounded)),
              ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => InkWell(
                  onTap: (){
                    slctdclrindex = index;
                    print(slctdclrindex);
                    setState(() {
                      
                    });
                  },
                  child: Container(
                  height: 60, width: 60,decoration: BoxDecoration(border: Border.all(width: slctdclrindex == index ? 0 : 5,color: Colors.amber),   borderRadius: BorderRadius.circular(10),color: NoteScreenController.colorlist[index]),
                            ),
                ) ),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if(isedit == true){
                         NoteScreenController.editnote(
                          index: index!,
                        title: _title.text,
                        desc: _desc.text,
                        date: _date.text,
                        clrindex: slctdclrindex,
                        

                      );
                      }
                      else{
                    addnote(
                        title: _title.text,
                        desc: _desc.text,
                        date: _date.text,
                        clrindex: slctdclrindex,
                        

                      );
                      }
                      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NotesScreen()));
                      setState(() {
                        
                      });
                    },
                    child: Container(
                       width: 100,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: Text(isedit== true? "Edit" : "Save")),
                    ),
                  ),
                   InkWell(
                    onTap: () {
                       Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NotesScreen()));
                      setState(() {
                        
                      });
                    },
                     child: Container(
                      width: 100,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: Text("Cancel ",style: TextStyle(color: Colors.red),)),
                                   ),
                   ),
                ],
              )
              ],
              ),
              ),
                      );
            }
          ));
      }
}
