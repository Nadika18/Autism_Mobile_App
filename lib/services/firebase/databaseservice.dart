import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/services/models/child.dart';
import 'package:easytalk/services/models/tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ParentDataBaseService {
  var user = FirebaseAuth.instance.currentUser;
  List<String> dependentCode = List<String>();
  List<Child> dependentChild = List<Child>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> parentDocumentExists(String id) async {
    DocumentSnapshot ref = await _firestore.collection("parents").doc(id).get();
    return ref.exists;
  }

  Future<void> createUserDoc() async {
    var ref = _firestore.collection("parents").doc(user.uid);
    var exists = await parentDocumentExists(user.uid);
    if (!exists) {
      Map<String, dynamic> data = {
        "uid": user.uid,
        "email": user.email,
        "photourl": user.photoURL,
        "name": user.displayName,
      };
      ref.set(data);
    }
  }

  Future<DocumentSnapshot> getUserDoc() async {
    var ref = _firestore.collection("parents").doc(user.uid);
    return ref.get();
  }

  Future<void> getDependents() async {
    var ref = _firestore.collection("children").where("parentuid",isEqualTo: user.uid);
    var dependents = await ref.get();
    if(dependents != null){
    dependents.docs.forEach((value){
      var data = value.data();
      dependentChild.add(Child.fromJson(data));
      dependentCode.add(data["regCode"]);
      });
    }
  }
  Future<bool> checkDependentExists(String regCode) async {
    var ref = await _firestore.collection("children").doc(regCode).get();
    return ref.exists;
  }

  Future<void> addTask(Task task,String regCode) async {
    var ref = _firestore.collection("tasks").doc(user.uid);
    var childref = ref.collection(regCode).doc();
    return childref.set(task.toJson());
  }

  Future<void> addDependent(Child child) async {
    var ref = _firestore.collection("children").doc(child.regCode);
    Map<String, dynamic> data = { "parentuid" : user.uid};
    data.addAll(child.toJSON());
    var check = await checkDependentExists(child.regCode);
    if (!check) {
      return ref.set(data);
    }
    return null;
  }
}

class ChildDataBaseService {
  String regCode;
  String parentuid;
  ChildDataBaseService({@required this.regCode});
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<QuerySnapshot> getTaskData(String regCode){
  }
}
