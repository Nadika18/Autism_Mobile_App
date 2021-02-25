import 'package:cloud_firestore/cloud_firestore.dart';

List<String> todoName = ["krishbin", "Make your Nadika"];
List<String> todoDesp = ["fjkdj", "Be sure to be tucked in tightly"];
List<DateTime> dateTime = [DateTime.parse("2020-12-01")];
List<bool> completed = [false];

class Task {
  Task({this.name, this.description, this.datetime, this.completed = false});

  String name;
  String description;
  DateTime datetime;
  String photourl;
  bool completed;

  Task.fromSnapshot(DocumentSnapshot snapshot) {
    _fromJson(snapshot.data());
  }

  Task.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

  _fromJson(Map<String, dynamic> json) {
    description = json["description"];
    name = json["name"];
    photourl = json["photourl"];
    var timestamp = json["datetime"];
    datetime = DateTime.parse(timestamp.toDate().toString());
    print(name);
    completed = json["completed"];
  }

  void toogleCompleted() {
    completed = !completed;
  }
}
