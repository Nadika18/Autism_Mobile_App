import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/services/models/child.dart';
import 'package:easytalk/services/models/tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentDataBaseService {
  var user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> parentDocumentExists(String id) async {
    DocumentSnapshot ref = await _firestore.collection("parents").doc(id).get();
    return ref.exists;
  }

  Future<void> createUserDoc() async {
    var ref = _firestore.collection("parents").doc(user.uid);
    var exists = await parentDocumentExists(user.uid);
    print("outside");
    if (!exists) {
      print("inside");
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

  Future<bool> checkDependentExists(String regCode) async {
    var ref = await _firestore.collection("children").doc(regCode).get();
    return ref.exists;
  }

  Future<void> printData(Future<DocumentSnapshot> snapshot) async {
    var snap = await snapshot;
    print(snap.data());
  }

  Future<void> addTask(String regCode) {}
  Future<void> addDependent(String name, String regCode) async {
    var ref = _firestore.collection("children").doc(regCode);
    Map<String, dynamic> child = {"name": name, "regCode": regCode};
    Map<String, dynamic> data = {"children": child};
    var check = await checkDependentExists(regCode);
    if (!check) {
      return ref.set(data);
    }
    return null;
  }
}

class ChildDataBaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> markCompleted(Task task) {}
}
