import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/data/Todo.dart';
class TodoProvider with ChangeNotifier{
  List<Todo> tasks;
  TodoProvider(): this.tasks=[];
  //late Todo item;
  final ref = FirebaseFirestore.instance.collection(Todo.collectionName)
      .withConverter<Todo>(fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!)
      ,toFirestore: (item, _) => item.toJson());
  Future<void> addNewTaskToFireStore(String title,String description,DateTime dateTime){
    DocumentReference<Todo> documentReference = ref.doc();
    Todo item =Todo(documentReference.id, title, description, dateTime);
    return documentReference.set(item);
  }
  void addTask(Todo todo){
    tasks.add(todo);
    notifyListeners();
  }
  Future<String?> getTasks (DateTime selectedDay)async{
    try{
    tasks.clear();
    tasks = [];
    final q_ss =await ref.where('dateString',isEqualTo: DateFormat('dd/MM/yyyy').format(selectedDay)).get();
    q_ss.docs.forEach((element) {
      tasks.add(element.data());
    });
    notifyListeners();
    return null;
    }
    catch(e){
      return 'Error: '+e.toString();
    }
  }
  Future<String?> deleteTask(Todo todo) async{
    try {
      await ref.doc(todo.id).delete();
      tasks.remove(todo);
      notifyListeners();
      return null;
    }
    catch(e)
    {
      print(e);
      return 'Error: '+e.toString();
    }
  }
  Future<String?> updateStatus(Todo todo)async{
    try{
    todo.isDone = !todo.isDone;
    await ref.doc(todo.id).set(todo);
    notifyListeners();
    return null;
    }
    catch(e)
    {
      todo.isDone = !todo.isDone;
      print(e);
      return 'Error: '+e.toString();
    }
  }
  Future<String?> editTaskData(Todo todo)async{
    try{
      var collection = FirebaseFirestore.instance.collection('Tasks');
      await collection.doc(todo.id).update(todo.toJson());
      print(todo.description);
      notifyListeners();
      return null;
    }catch(e){
      return 'Editing Data Failed';
    }
  }
}