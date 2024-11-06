
import 'package:database_basic_practice/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  List<Map<String,dynamic>> mNotes=[];
  TextEditingController titleController= TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,
          title: Text("Detail Page"),),
        body: Container(
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30))
              ),
              isDismissible: false,
              context: context, builder: (context) {
              return Text("hello");
                //newScreen(isUpdate: false,mID:0);
          });
        },
          tooltip: "Add Pages",
          child: Icon(Icons.add),
        ),



    );
  }
 // bool isUpdate =false;
 //  Widget newScreen({bool isUpdate=true, int mID=0}) {
 //    return Container(
 //      height: 200,
 //      child: Column(
 //        children: [
 //          SizedBox(height: 30,),
 //          Text("Add Notes",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),),
 //          SizedBox(height: 30,),
 //          TextField(
 //            controller: titleController,
 //            decoration: InputDecoration(
 //              hintText: "Enter you Title",
 //              labelText: "Title",
 //              fillColor: Colors.white,
 //              filled: true,
 //              enabledBorder: OutlineInputBorder(
 //                borderRadius: BorderRadius.circular(10)
 //              ),
 //              focusedBorder: OutlineInputBorder(
 //                borderRadius: BorderRadius.circular(10)
 //              )
 //            ),
 //          ),
 //          SizedBox(height: 30,),
 //          TextField(
 //            controller: descController,
 //            decoration: InputDecoration(
 //                hintText: "Enter you Description",
 //                labelText: "Description",
 //                fillColor: Colors.white,
 //                filled: true,
 //                enabledBorder: OutlineInputBorder(
 //                    borderRadius: BorderRadius.circular(10)
 //                ),
 //                focusedBorder: OutlineInputBorder(
 //                    borderRadius: BorderRadius.circular(10)
 //                )
 //            ),
 //          ),
 //          Row(
 //            children: [
 //              OutlinedButton(onPressed: () {
 //             context.read<DBProvider>().addData();
 //
 //              }, child: Text("Add")),
 //              OutlinedButton(onPressed: (){
 //
 //              }, child: Text("Cancel"))
 //            ],
 //          )
 //        ],
 //      ),
 //    );
 //  }



  }