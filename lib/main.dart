
import 'package:database_basic_practice/database_helper.dart';
import 'package:database_basic_practice/db_provider.dart';
import 'package:database_basic_practice/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context){
    return DBProvider();
  }, child: MyApp()));
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{

  // List<Map<String,dynamic>> mNotes=[];

  DataBaseHelper db= DataBaseHelper.db;
  // @override
  // void initState() {
  //   super.initState();
  //   getAllNotes();
  // }
  // getAllNotes() async{
  //   allNotes= await DataBaseHelper.db.fetchAllNotes() ;
  //   setState(() {
  //
  //   });
  // }
   TextEditingController titleController=TextEditingController();
  TextEditingController descController=TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("Shrinet NoteKeeper",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.blue)),

      ),

      body:Consumer<DBProvider>(builder: (context,providerValue,child){
        List<Map<String,dynamic>> mNotes= providerValue.getAllNotes();
        return mNotes.isNotEmpty? Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: mNotes.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onLongPress: (){
                      showModalBottomSheet(context: context, builder: (context){
                        titleController.text=mNotes[index][DataBaseHelper.User_Note_Title];
                         descController.text=mNotes[index][DataBaseHelper.User_Note_Description];

                        return newScreen(isUpdate:true,mID: mNotes[index][DataBaseHelper.User_Note_ID]);
                      });
                    },
                    leading: Column(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${index+1}.",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.red),),
                        SizedBox(height: 17,)
                      ],
                    ),
                    title: Text(mNotes[index][DataBaseHelper.User_Note_Title],style:TextStyle(fontSize:20,fontWeight:FontWeight.w400,color:Colors.green)),
                    subtitle: Text(mNotes[index][DataBaseHelper.User_Note_Description],style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: Colors.orange),),
                    trailing: IconButton(onPressed: () async{
                      providerValue.deleteData(id: mNotes[index][DataBaseHelper.User_Note_ID]);

                    },icon: Icon(Icons.delete)),
                  );
                }),
          )],): Center(child: Text("Add Notes Here",
            style:TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.red))
        );
      },),

      floatingActionButton:FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        onPressed: () {
  Navigator.push(context, MaterialPageRoute(builder: (context){
    return newScreen(isUpdate:false,mID: mNotes[index][DataBaseHelper.User_Note_ID]);
  }));

      },
      child: Icon(Icons.add),
      )
    );
  }

  bool  isUpdate = false;

   Widget newScreen({ bool isUpdate=false , int mID=0}){
    return  Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.5 + MediaQuery
          .of(context)
          .viewInsets
          .bottom,

      decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(30)
      ),
      child: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.only(
              top: 15, left: 15, right: 15, bottom: 15 + MediaQuery
              .of(context)
              .viewInsets
              .bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(isUpdate ? "Update Note" : "ADD Note",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,)
              ),
              SizedBox(height: 15,),
              Text(isUpdate
                  ? "Update Note Here By Using Title And Description "
                  : "Add Note Here By Using Title And Description",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),),
              const SizedBox(height: 15,),
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      fillColor: Colors.yellow,
                      focusColor: Colors.white,
                      hintText: "Input Title Here",
                      labelText: "Title",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  )
              ),
              const SizedBox(height: 15,),
              TextField(
                  controller: descController,
                  decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.white,
                      hintText: "Input Description Here",
                      labelText: "Description",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      )
                  )
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  OutlinedButton(onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        descController.text.isNotEmpty) {
                      if (isUpdate) {
                        context.read<DBProvider>().updateData(
                            title: titleController.text,
                            description: descController.text,
                            id: mID);
                        titleController.clear();
                        descController.clear();
                        Navigator.pop(context);
                      } else {
                        context.read<DBProvider>().addData(
                            title: titleController.text,
                            description: descController.text);
                        titleController.clear();
                        descController.clear();
                        Navigator.pop(context);
                      }


                      // if (isUpdate) {
                      //   check = await DataBaseHelper.db.updateNotes(
                      //     title: titleController.text.toString(),
                      //     description: descController.text.toString(),
                      //     ID: mID ,
                      //
                      //   );
                      //
                      // } else{
                      //   // check = await DataBaseHelper.db.insertNotes(title: titleController.text,
                      //   //    description: descController.text);

                      // }

                      // if(check){
                      //    // providerValue.getAllNotes();
                      //   titleController.clear();
                      //   descController.clear();
                      //   Navigator.pop(context);
                      // }
                    }

                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                              "Enter The Fields Of Title And Description")));
                    }
                  }, child: Text("Add")),

                  OutlinedButton(onPressed: () {
                    titleController.clear();
                    descController.clear();
                    Navigator.pop(context);
                  }, child: Text("Cancel")),

                ],
              )

            ],
          ),
        ),
      ),


    );
  }
}
