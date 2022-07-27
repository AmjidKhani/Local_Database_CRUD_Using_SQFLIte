import 'package:localdatabase/Modelclass.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io'as io;
import 'package:sqflite/sqflite.dart';
class DBHelper{
  static Database? _db;
  Future<Database?> get db async{
    if(_db!=null){
      return _db;
    }
    _db=await initilizeddatabase();
  }

  initilizeddatabase() async {
    io.Directory documentDirectory= await getApplicationDocumentsDirectory();
    String path=join(documentDirectory.path,'name.db');
    var db=openDatabase(path,version: 1,onCreate: _oncreate);
  return db;
  }
  _oncreate(Database db,int version)async{
    await db.execute("CREATE TABLE name(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT NOT NULL,description TEXT NOT NULL,age INTEGER,email TEXT NOT NULL)");
  }
  Future<NotesModel> insert(NotesModel notesModel)async{
    var dbClient=await db;
    dbClient?.insert('tname', notesModel.toMap());
    return notesModel;
  }
  Future<List<NotesModel>> togetNoteslist()async{
    var dbClient=await db;
    final List<Map<String,Object?>> queryResult=await dbClient!.query("name");
    return queryResult.map((e) => NotesModel.fromModel(e)).toList();
  }
}