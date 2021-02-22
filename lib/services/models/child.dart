import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/services/models/tasks.dart';

class Child {
  String uid;
  String name;
  String photourl;
  String regCode;
  List<Task> tasks = List<Task>();

  Child(String uid) : this.uid = uid;
  Child.fromSnapshot(DocumentSnapshot snapshot) {
    _fromJson(snapshot.data());
  }

  Child.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

  _fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    photourl = json["photourl"];
    name = json["name"];
    regCode = json["regCode"];
    List<dynamic> _tasks = json["tasks"];
    for (var task in _tasks) {
      tasks.add(Task.fromJson(task));
    }
  }

  int getNoOfTask() => tasks.length;

  void completedTask(String id) {
    for (var task in tasks) {
      if (task.uid == id) {
        task.toogleCompleted();
        //TODO: server side
      }
    }
  }

  Task getNearest() {
    return tasks.first;
  }

  void addTask(Task task) {
    tasks.add(task);
    //TODO: server side
  }

  void addTaskFromJson(Map<String, dynamic> json) {
    tasks.add(Task.fromJson(json));
  }
}
