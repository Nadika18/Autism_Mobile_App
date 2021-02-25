import 'package:easytalk/parent/createQuestions.dart';
import 'package:easytalk/parent/dependents.dart';
import 'package:easytalk/parent/questionsFromParents.dart';
import 'package:easytalk/parent/rewards.dart';
import 'package:easytalk/parent/taskview.dart';
import 'package:easytalk/services/firebase/databaseservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easytalk/services/firebase/authservice.dart';
import 'package:easytalk/loginscreen.dart';
import 'package:easytalk/child/childPecs.dart';
import 'package:easytalk/utils/customWidgets.dart';
import "package:easytalk/parent/manage_routine.dart";
import 'package:easytalk/parent/questionsFromParents.dart';

class ParentHomePage extends StatefulWidget {
  ParentHomePage({Key key}) : super(key: key);
  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  String name, email, imagelink;
  @override
  void initState() {
    super.initState();
    name = user.displayName;
    email = user.email;
    imagelink = user.photoURL;
  }

  Widget _buildTopView(Size size) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      height: size.height / 5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(9)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 0),
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            leading: Container(
                width: 60, child: circularImageContainerLink(imagelink, 50)),
            title: Text(name),
            subtitle: Text(email),
            trailing: FlatButton(
                padding: EdgeInsets.all(0),
                child: Text("View Profile"),
                textColor: Colors.blue[600],
                onPressed: () {}),
          ),
          Container(
            child: ListTile(
              leading: Text("Logged in as Parent.",
                  style: TextStyle(color: Colors.grey[600])),
              trailing: FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text("Sign Out"),
                  textColor: Colors.red,
                  onPressed: () {
                    final auth =
                        Provider.of<AuthService>(context, listen: false);
                    auth.signOutWithGoogle();
                    Navigator.of(_scaffoldKey.currentContext)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => MainLoginScreen()),
                            (Route<dynamic> routes) => false);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(String tileName, IconData icon, var func) {
    return InkWell(
      child: new Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            Text(tileName, style: TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
      ),
      onTap: func,
    );
  }

  void navigateTaskView() {
    Navigator.push(_scaffoldKey.currentContext,
            MaterialPageRoute(builder: (context) => TaskView(uid: name)))
        .then((value) => setState(() {}));
  }

  void navigatePecs() {
    Navigator.push(
      _scaffoldKey.currentContext,
      MaterialPageRoute(
        builder: (context) => ChildPecs(),
      ),
    );
  }

  void navigateDependents() {
    Navigator.push(_scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => Dependents()));
  }

  void navigateQuestions() {
    Navigator.push(_scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => CreateQuestion()));
  }

  void navigateManageRoutine() {
    Navigator.push(_scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => ManageRoutine()));
  }
  void navigateRewards() {
    Navigator.push(_scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => Rewards()));
  }

  void navigateTutorials(){
    Navigator.push(_scaffoldKey.currentContext,
        MaterialPageRoute(builder: (context) => QuestionsByParents()));
  }

  Widget _buildGridView(Size size) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: (size.width / 2) / (size.height / 5),
      children: [
        _buildGridItem("Manage Routine", Icons.calendar_today, navigateManageRoutine),
        _buildGridItem(
            "Dependents", Icons.perm_identity_rounded, navigateDependents),
        _buildGridItem("Tasks", Icons.pending_actions, navigateTaskView),
        _buildGridItem("Reports", Icons.library_books_outlined, null),
        _buildGridItem("Rewards", Icons.auto_awesome, navigateRewards),
        _buildGridItem("PECS", Icons.picture_in_picture_sharp, navigatePecs),
        _buildGridItem("Tutorials", Icons.assignment_turned_in_outlined, navigateTutorials),
        _buildGridItem(
            "Questions", Icons.question_answer_sharp, navigateQuestions),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(5),
          height: size.height / 4.8,
          child: _buildTopView(size),
        ),
        Container(
            padding: const EdgeInsets.only(left: 8, bottom: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Manage Dependents",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            )),
        Container(
            child: Expanded(
          child: _buildGridView(size),
        ))
      ]),
    ));
  }
}
