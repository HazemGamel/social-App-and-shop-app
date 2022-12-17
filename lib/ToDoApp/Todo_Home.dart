import 'package:first_app/ToDoApp/Archive.dart';
import 'package:first_app/ToDoApp/Done.dart';
import 'package:first_app/ToDoApp/Tasks.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class TodoHome extends StatefulWidget {
  @override
  _TodoHomeState createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  List<Widget> screens=[
    Tasks(),
    Done(),
    Archive(),
  ];

  int currentindex=0;
  Database database;
  var scaffoledkey=GlobalKey<ScaffoldState>();
  IconData iconData=Icons.edit;
  bool isShow=false;
  var Taskcontroler=TextEditingController();
  var Datecontroler=TextEditingController();
  var Timecontroler=TextEditingController();
  @override
  void initState() {
    super.initState();
    creatdatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoledkey,
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: screens[currentindex],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(isShow){
            Navigator.pop(context);
            isShow=false;
            setState(() {
              iconData=Icons.edit;
            });

          }else{
            scaffoledkey.currentState.showBottomSheet((context) =>
                Container(
                  width: double.infinity,
                  color: Colors.blueAccent[100],
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller:Taskcontroler ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Tasks',
                          prefixIcon: Icon(Icons.title),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return 'pleas enter your tasks';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller:Taskcontroler ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Tasks',
                          prefixIcon: Icon(Icons.title),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return 'pleas enter your tasks';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller:Taskcontroler ,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          labelText: 'Tasks',
                          prefixIcon: Icon(Icons.title),
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return 'pleas enter your tasks';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                )
            );

            isShow=true;
            setState(() {
              iconData=Icons.add;
            });

          }

        },
        child: Icon(iconData),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentindex,
        onTap: (index){
          setState(() {
            currentindex=index;
          });
        },
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.menu),label: 'tasks'),
          BottomNavigationBarItem(icon:Icon(Icons.check_circle_outline),label: 'Done'),
          BottomNavigationBarItem(icon:Icon(Icons.archive_outlined),label: 'Archive'),
        ],
      ),
    );
  }
  void creatdatabase()async{
     database=await openDatabase('ToDoo.db',
      version: 1,
      onCreate: (database,version){
      print("database created");
      database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY ,title TEXT,date TEXT,time TEXT,status TEXT)').then((value) {
        print("Table Created");
      }).catchError((error){
        print("$error");
      });
      },
      onOpen: (database){
      print("DataBase opened");
    }

    );
  }
  Future insertdatabase()async{
   return await database.transaction((txn)async{
   return await txn.rawInsert(
       'INSERT INTO tasks(title,date,time,status) VALUES("first","345","77","new")')
       .then((value) {
        print("$value Successfly");
      }).catchError((error){
        print("error is $error");
      });
    });
     return null;
  }
}
