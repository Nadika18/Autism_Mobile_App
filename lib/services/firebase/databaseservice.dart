import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easytalk/services/models/parent.dart';
import 'package:flutter/material.dart';

class DataBaseService {
  DataBaseService({@required this.uid}) : assert(uid != null);
  final String uid;
  Parent parent;
  Future<DocumentSnapshot> getUserDoc() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference ref = _firestore.collection('parents').doc(uid);
    return ref.get();
  }

  Future<void> printData(Future<DocumentSnapshot> snapshot) async {
    var snap = await snapshot;
    print(snap.data());
  }
}
