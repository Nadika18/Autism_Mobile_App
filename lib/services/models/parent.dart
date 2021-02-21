import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/services/models/child.dart';
import 'package:easytalk/services/firebase/databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Parent {
  String photourl;
  String uid;
  String name;
  String email;
  List<Child> children = List<Child>();

  Parent({@required this.uid});
  Parent.fromSnapshot(DocumentSnapshot snapshot) {
    _fromJson(snapshot.data());
  }

  Parent.fromJson(Map<String, dynamic> json) {
    _fromJson(json);
  }

  _fromJson(Map<String, dynamic> json) {
    uid = json["uid"];
    photourl = json["photourl"];
    name = json["name"];
    email = json["email"];
    List<dynamic> childs = json['children'];
    for (var child in childs) {
      children.add(Child.fromJson(child));
    }
  }

  Future<void> _setChildDoc(String uid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference ref = _firestore.collection('child').doc(uid);
    ref.set({"uid": uid});
  }

  int getNoOfChild() => children.length;

  Future<void> createNewChild(String regCode, String passcode) async {
    var email = regCode + "@easytalk.com";
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: passcode);
      await _setChildDoc(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
