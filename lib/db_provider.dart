
import 'package:database_basic_practice/database_helper.dart';
import 'package:flutter/material.dart';

class DBProvider extends ChangeNotifier{

List<Map<String,dynamic>> _mNotes=[];

 void addData({required String title, required String description}) async{
  bool rowsEffect = await DataBaseHelper.db.insertNotes(title: title, description: description) ;
  if(rowsEffect){
    fetchData();
  }
  }
  void updateData({required String title, required String description , required int id}) async{
   bool rowsEffect = await DataBaseHelper.db.updateNotes(title: title, description: description, ID: id);
   if(rowsEffect){
     fetchData();
   }
  }
   void deleteData({ required int id}) async{
  bool rowsEffect = await DataBaseHelper.db.deleteNotes(ID: id);
  if(rowsEffect){
   fetchData();
  }
  }



   void fetchData() async{
   _mNotes = await DataBaseHelper.db.fetchAllNotes();
}

 List<Map<String,dynamic>> getAllNotes(){
     return _mNotes;

}


}