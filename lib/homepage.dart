import 'package:easytalk/parent/parentHomepage.dart';
import 'package:easytalk/services/firebase/databaseservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var dbase = Provider.of<ParentDataBaseService>(context, listen: false);
    dbase.createUserDoc();
    dbase.getDependents();
    return ParentHomePage();
  }
}
