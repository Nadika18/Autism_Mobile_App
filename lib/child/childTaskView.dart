import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/services/models/child.dart';
import 'package:easytalk/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChildTaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<ChildTaskView> {
  @override
  Widget build(BuildContext context) {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    var child = Provider.of<Child>(context, listen: false);
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
        body: new StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .doc(child.parentuid)
                .collection(child.regCode)
                .orderBy("timestamp")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return new ListView(
                  padding: EdgeInsets.all(5),
                    itemExtent: 80,
                    children: snapshot.data.docs.map((document) {
                      var data = document.data();
                      Timestamp tstamp = (document.data())["timestamp"];
                      var dtime = tstamp.toDate();
                      return new Card(
                        elevation: 10,
                        color: data["completed"]?Colors.purple[100]:Colors.white,
                          child: ListTile(
                        leading: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              rectangularImageContainerNoAlign(
                                  data["photourl"] == null
                                      ? "assets/defaulttask.png"
                                      : data["photourl"],
                                  40),
                            ]),
                        title: Text(data['name'].toString(),
                            style: TextStyle(fontSize: 22)),
                        subtitle: Text(data['description'].toString(),
                            style: TextStyle(fontSize: 18)),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              months[dtime.month - 1] +
                                  " - " +
                                  dtime.weekday.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              dtime.hour.toString() +
                                  " : " +
                                  dtime.minute.toString(),
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ));
                    }).toList());
              }
            }));
  }
}
