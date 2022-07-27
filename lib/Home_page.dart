import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localdatabase/Modelclass.dart';
import 'DBHelper.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);
  @override
  State<homepage> createState() => _homepageState();
}
class _homepageState extends State<homepage> {
  DBHelper? dbHelper;
  //List creation

late Future<List<NotesModel>> noteslist;
  loadData()async{
    noteslist=dbHelper!.togetNoteslist();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SqfLite Database Notes App"),
        centerTitle: true,
      ),
      body: Column(
        children: [
FutureBuilder(
  future: noteslist,
    builder: (
        context,
        AsyncSnapshot<List<NotesModel>>snapshot)
    {
      if(snapshot.hasData)
      {
        return ListView.builder(
          itemCount: snapshot.data?.length,
            itemBuilder: (context,index)
        {
          return Card(
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title:Text(snapshot.data![index].title.toString()),
              subtitle: Text(snapshot.data![index].description.toString()),
              trailing: Text(snapshot.data![index].age.toString()),

            ),
          );
        }
        );
      }
      else {
        return CircularProgressIndicator();
      }
    }
),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dbHelper!.insert(
              NotesModel(
            title: 'First Flutter Notes',
            description: "My First FLutter App",
            age: 23,
            email: 'alikhan12@gmail.com',
          )).then((value) {
            print("DATA ADDED");
          }).onError((error, stackTrace) {
            print(error.toString());
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
