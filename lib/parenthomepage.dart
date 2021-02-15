import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forms.dart';
import 'childpecs.dart';
import 'utils.dart'; 

class ParentHomePage extends StatefulWidget {
  ParentHomePage({Key key}):super(key:key);
  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  String name,email,imagelink;
  @override
  void initState(){
    super.initState();
    name = user.displayName;
    email = user.email;
    imagelink = user.photoURL;
  }

  Widget _buildTopView(Size size){
    return Container(
        padding: EdgeInsets.fromLTRB(0,5,0,0),
        height: size.height/5,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 7,
                  offset: Offset(0,0),
              ),
            ]
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                  leading: Container(
                      width:60,
                      child:CircularImageContainerLink(imagelink,50)),
                  title: Text(name),
                  subtitle: Text(email),
                  trailing: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Text("View Profile"),
                      textColor: Colors.blue[600],
                      onPressed: (){
                      }
                  ),
              ),
              Container(
                  child: ListTile(
                      leading: Text("Logged in as Parent.",style:
                          TextStyle(color: Colors.grey[600])),
                      trailing:FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text("Change"),
                          textColor: Colors.blue[600],
                          onPressed: (){
                          }
                      ),

                  ),
              ),
              ],
              ),
              );
  }

  Widget _buildGridItem(String tileName,IconData icon,var func){
    return InkWell(
        child: new Card(
            elevation: 10,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon),
                  Text(tileName,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      )), 
                ],
            ),
        ),
        onTap:func,
    );
  }

  void _gotoTaskForm(){
    var _context = _scaffoldKey.currentContext;
    Navigator.push(_context,
        MaterialPageRoute(builder: (_context) =>
            BaseForm())
    ).then((value)=> setState((){}));
  }

  void navigatePecs(){
    Navigator.push(
        _scaffoldKey.currentContext, MaterialPageRoute(
            builder: (context) => ChildPecs(),
            ),
        );
  }

  Widget _buildGridView(Size size){
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (size.width/2)/(size.height/5),
        children: [
          _buildGridItem("Manage Routine",Icons.calendar_today,null),
          _buildGridItem("Dependents",Icons.perm_identity_rounded,null),
          _buildGridItem("Tasks",Icons.pending_actions,_gotoTaskForm),
          _buildGridItem("Reports",Icons.library_books_outlined,null),
          _buildGridItem("Rewards",Icons.auto_awesome,null),
          _buildGridItem("PECS",Icons.picture_in_picture_sharp,navigatePecs),
          _buildGridItem("Tutorials",Icons.assignment_turned_in_outlined,null),
          _buildGridItem("Questions",Icons.question_answer_sharp,null),
        ],
    );
  }

  @override
  Widget build(BuildContext context){
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child:
        Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.grey[200],
            body: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(5),
                      height: size.height/4.8,
                      child: _buildTopView(size),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left:8,bottom:5),
                      child:Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Manage Dependents",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                              )
                          ),
                      )),
                  Container(
                      child:Expanded(
                          child:_buildGridView(size),
                      ))
                ]
                ),
                  ));
  }
}
