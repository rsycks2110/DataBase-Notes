
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{

  // Creating Private Constructor Of DataBaseHelper class (Singleton)

    DataBaseHelper._();

 static final DataBaseHelper db = DataBaseHelper._();

  static const String User_NoteKeeper=" UserNotes";
    static const String User_Note_ID = "note_ID";
  static const String User_Table_Note =  "UserNotes";
  static const String User_Note_Title = "title";
  static const String User_Note_Description= "description";
//  static const String Notes_ID  = "notes_id";
  Database? mdb;
  // Gettind Database

  Future<Database> getDataBase() async{
    if(mdb!=null){
      return mdb!;

    } else{
      return await openDataBase();
    }
  }
  // Opening Database
  Future<Database> openDataBase()  async {
     var rootPath=  await getApplicationDocumentsDirectory();
     var dbPath =  join(rootPath.path, "Notes.db");
    return await  openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute(" create table $User_Table_Note ($User_Note_ID integer primary key autoincrement, $User_Note_Title text , $User_Note_Description text ) ");
    });

  }

  // Inserting Notes Into Database(Insert/ Create)

  Future<bool> insertNotes({ required String title, required String description}) async{
    var mainDataBase = await getDataBase();
   int  rowFill= await mainDataBase.insert(User_Table_Note,{
     User_Note_Title : title,
     User_Note_Description : description
   }) ;
  return rowFill>0;
  }
       // fetching Notes(Read Operation)
   Future<List<Map<String,dynamic>>> fetchAllNotes() async{
    var mainDataBase =  await getDataBase();
  List<Map<String,dynamic>> mNotes = await mainDataBase.query(User_Table_Note);
  return mNotes;
  }
  //Updating Notes(Changing Data )
  Future<bool> updateNotes({required String title , required String description, required int ID}) async{
    var mainDataBase = await  getDataBase();
  int rowUpdate= await mainDataBase.update(User_Table_Note, {
      User_Note_Title:title,
      User_Note_Description:description
    }, where: "$User_Note_ID= ?",whereArgs:["$ID"]);
  return rowUpdate>0;

  }
  Future<bool> deleteNotes({required int ID}) async{
       var mainDataBase = await getDataBase();
   int deleteTable = await mainDataBase.delete(User_Table_Note,where: "$User_Note_ID= ?",whereArgs:["$ID"]);
   return deleteTable>0;
  }


}