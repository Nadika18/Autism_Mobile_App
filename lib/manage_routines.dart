import "package:flutter/material.dart";

class ManageRoutine extends StatefulWidget {
  @override
  _ManageRoutineState createState() => _ManageRoutineState();
}

class _ManageRoutineState extends State<ManageRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left_sharp,
                  color: Colors.black, size: 45),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text(
            "Task View",
            style: TextStyle(color: Colors.black),
          )),
      body: SingleChildScrollView(
        
        
      ),
    );}
}