import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/parent/forms.dart';
import 'package:easytalk/services/firebase/databaseservice.dart';
import 'package:easytalk/services/models/tasks.dart';
import 'package:easytalk/utils/customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskView extends StatefulWidget {
  final String uid;
  TaskView({@required this.uid});
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  String uid;
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
    uid = widget.uid;
  }

    List months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
  @override
  Widget build(BuildContext context) {
    var dependents = Provider.of<ParentDataBaseService>(context);
    Widget b(int index) => Container(
      height: 500,
          child: Column(
            children: [
              ListTile(
                leading: circularImageContainerNoAlign(
                    dependents.dependentChild[index].photourl == null
                        ? "assets/defaultprofile.jpg"
                        : dependents.dependentChild[index].photourl,
                    40),
                    title: Text(dependents.dependentChild[index].name),
                    trailing: IconButton(icon: Icon(Icons.add),onPressed:(){
                      var regCode = dependents.dependentChild[index].regCode;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TaskForm(uid: regCode))).then((value)=>setState((){}));
                          
                    },),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(dependents.dependentChild[index].parentuid)
                      .collection(dependents.dependentChild[index].regCode)
                      .orderBy("timestamp")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return new ListView(
                        shrinkWrap: true,
                        controller: _controller,
                        scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(5),
                          itemExtent: 80,
                          children: snapshot.data.docs.map((document) {
                            var data = document.data();
                            Timestamp tstamp = (document.data())["timestamp"];
                            var dtime = tstamp.toDate();
                            return new Card(
                                elevation: 10,
                                color: data["completed"]
                                    ? Colors.purple[100]
                                    : Colors.white,
                                child: ListTile(
                                  leading: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                  })
            ],
          ),
        );
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
      body: b(0)    );
  }
}
