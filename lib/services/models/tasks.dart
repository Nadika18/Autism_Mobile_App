import 'package:cloud_firestore/cloud_firestore.dart';

List<String> todoName = ["krishbin", "Make your Nadika"];
List<String> todoDesp = ["fjkdj", "Be sure to be tucked in tightly"];
List<DateTime> dateTime = [
  DateTime.parse("2020-12-01"),
  DateTime.parse("2020-12-01")
];
List<bool> completed = [false];

class Task {
  Task({this.name, this.description, this.datetime, this.completed = false});

  String name;
  String description;
  DateTime datetime;
  String photourl;
  bool completed;
  toJson() {
    var tstamp = Timestamp.fromDate(datetime);
    return {
      "name": name,
      "description": description,
      "timestamp": tstamp,
      "photourl": photourl,
      "completed": completed
    };
  }

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
    Timestamp timestamp = json["timestamp"];
    datetime = timestamp.toDate();
    completed = json["completed"];
  }

  toggleCompleted(String id, String code) async{
    var ref = FirebaseFirestore.instance
        .collection("tasks")
        .doc(id)
        .collection(code)
        .where("timestamp", isEqualTo: Timestamp.fromDate(datetime));
        QuerySnapshot data = await ref.get();
        data.docs.first.reference.update({"completed":true});
  }
}
