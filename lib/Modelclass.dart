class NotesModel{
  int? id;
  String? title;
String? description;
int? age;
String? email;
NotesModel({
    this.id,
  this.title,
  this.description,
  this.age,
  this.email
});
NotesModel.fromModel(Map<String,dynamic>res):
      id=res['id'],
  title=res['title'],
  description=res['description'],
  age=res['age'],
  email=res['email'];
Map<String,Object?> toMap(){
 return
 {
 'id':id,
 'title':title,
  'description':description,
  'age':age,
  'email':email,
 };
}
}