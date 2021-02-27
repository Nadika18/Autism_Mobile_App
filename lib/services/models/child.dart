import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/services/models/tasks.dart';

class Child {
  String name;
  String parentuid;
  String photourl;
  String regCode;
  int age;
  String gender;
  List<Task> tasks = List<Task>();
  Child({this.name,this.photourl,this.regCode,this.age,this.gender});

  Child.fromSnapshot(DocumentSnapshot snapshot) {
    _fromJson(snapshot.data());
  }

  Child.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

  _fromJson(Map<String, dynamic> json) {
    photourl = json["photourl"];
    name = json["name"];
    regCode = json["regCode"];
    gender = json["gender"];
    age = json["age"];
    parentuid = json["parentuid"];
    print("Name:" +name);
    print("regCode:"+ regCode);
  }

  toJSON() {
    return {
    "photourl": photourl,
    "name": name,
    "regCode":regCode,
    "gender":gender,
    "age":age,
    };
  }
  int getNoOfTask() => tasks.length;

  void completedTask(DateTime dtime) {
    for (var task in tasks) {
      if (task.datetime == dtime) {
      }
    }
  }

  Task getNearest() {
    return tasks.first;
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  void addTaskFromJson(Map<String, dynamic> json) {
    tasks.add(Task.fromJson(json));
  }

}
