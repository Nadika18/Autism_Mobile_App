import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easytalk/child/childTaskView.dart';
import 'package:easytalk/child/feelings.dart';
import 'package:easytalk/services/models/child.dart';
import 'package:flutter/material.dart';
import 'package:easytalk/utils/customWidgets.dart';
import 'package:easytalk/services/models/tasks.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

FlutterTts flutterTts = FlutterTts();
speak(String text) async {
  String _text = text;
  await flutterTts.setLanguage("en US");
  await flutterTts.setPitch(1);
  await flutterTts.setVolume(1.0);
  await flutterTts.speak(_text);
}

class ChildHomePage extends StatefulWidget {
  ChildHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChildHomePageState createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Task latestTask;

  @override
  Widget build(BuildContext context) {
    var child = Provider.of<Child>(context);
    Size size = MediaQuery.of(context).size;

    Widget _hearTodaysStatus() {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.blue[400],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.campaign, size: 40),
            SizedBox(
              width: 20,
            ),
            TextButton(
                child: Text("Hear todays status",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white)),
                onPressed: () {
                  if (latestTask == null) {
                    speak("You are upto date");
                  } else {
                    speak(latestTask.name + latestTask.description);
                  }
                })
          ]),
        ),
        onTap: () {
          print("tapped");
          //works okay
        },
      );
    }

    Widget _remainingTasks(int length) {
      return InkWell(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.orange[500],
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(length.toString(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            SizedBox(
              width: 20,
            ),
            Text("remaining tasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
          ]),
        ),
        onTap: () {
          Navigator.of(_scaffoldKey.currentContext)
              .push(MaterialPageRoute(builder: (_) => ChildTaskView()));
        },
      );
    }
    Query query = FirebaseFirestore.instance
              .collection("tasks")
              .doc(child.parentuid)
              .collection(child.regCode)
              .where("timestamp",isGreaterThan: Timestamp.now())
              .orderBy("timestamp");

    Widget _currentTask(Size size) {
      return StreamBuilder<QuerySnapshot>(
          stream: query.snapshots(),
          builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot){ 
                    var task;
                    if(snapshot.hasData){
                    var querylatest = snapshot.data.docs.map((value)=>value.data());
                    for (var item in querylatest) {
                      if(item["completed"] == false){
                        task = Task.fromJson(item);
                        break;
                      }
                    }
                    }else{
                    task =null;
                    }
                    latestTask = task;
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Stack(children: [
                  Container(
                      height: size.height * 2 / 6.5,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              width: size.width * 0.55 - 3,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5)),
                                  child: Image(
                                      image: AssetImage('assets/bed.jpg')))),
                          Positioned(
                              right: 0,
                              width: size.width * 0.45 - 3,
                              height: size.height * 1.8 / 6.5,
                              child: task != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          task.name.toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(
                                              task.description.toString(),
                                              textAlign: TextAlign.center,
                                            )),
                                        Container(
                                            padding: const EdgeInsets.all(15),
                                            child: Text(
                                              task.datetime.toString(),
                                              textAlign: TextAlign.center,
                                            )),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("All task completed",
                                            style: TextStyle(fontSize: 20))
                                      ],
                                    )),
                        ],
                      )),
                  Positioned(
                      bottom: 0,
                      width: size.width - 6,
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 7,
                                blurRadius: 7,
                                offset: Offset(0, -3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.fromLTRB(0, 3, 0, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.volume_up),
                                onPressed: () {
                                  if(task!=null){
                                    speak(task.name + " " + task.despcription);
                                  }
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.done_sharp),
                                onPressed: () {
                                  if(task!=null){
                                  task.toggleCompleted(child.parentuid,child.regCode);
                                  }
                                },
                              ),
                            ],
                          ))),
                ]),
              );});
    }

    Widget _feelings() {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(Icons.mood, size: 50),
                onPressed: () {
                  Navigator.of(_scaffoldKey.currentContext)
                      .push(MaterialPageRoute(builder: (_) => Feelings()));
                }),
            SizedBox(
              height: 20,
            ),
            Text("How are you feeling?", style: TextStyle(fontSize: 20))
          ],
        ),
      );
    }

    Widget _createTopView() {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  child: Icon(Icons.mood),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                ),
                circularImageContainer(
                    (child.photourl == null || child.photourl == "")
                        ? "assets/defaultprofile.jpg"
                        : child.photourl,
                    55.0),
                Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(child.name),
                        Row(
                          children: [
                            Text(child.gender),
                            Text("   "),
                            Text(child.age.toString())
                          ],
                        )
                      ]),
                )
              ]));
    }

    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                ),
                child: Text(
                  "Welcome User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )),
          ],
        )),
        body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("tasks")
                  .doc(child.parentuid)
                  .collection(child.regCode)
                  .where("completed", isEqualTo: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.data == null){
                      return Center(child: CircularProgressIndicator(),);
                    }
                var left = snapshot.data.docs.where((value)=>(value.data())["timestamp"].toDate().isAfter(DateTime.now()));
                print(left.length);
                return Stack(children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: size.width,
                        minHeight: 70,
                        maxHeight: 70,
                      ),
                      child: _createTopView(),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(3, 4, 3, 0),
                      height: (size.height - 70) / 6.5,
                      child: _hearTodaysStatus(),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(3, 4, 3, 0),
                      height: (size.height - 70) / 6.5,
                      child: _remainingTasks(left.length),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(3, 4, 3, 0),
                      height: (size.height - 70) * 2.5 / 6.5,
                      child: _currentTask(size),
                    ),
                    Container(
                      height: (size.height - 70) * 1.5 / 6.5,
                      padding: const EdgeInsets.fromLTRB(3, 13, 3, 0),
                      child: _feelings(),
                    ),
                  ])
                ]);
              }),
        ));
  }
}
