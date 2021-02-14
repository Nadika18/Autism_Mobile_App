import 'dart:ui';
import 'package:flutter/material.dart';
import './utils.dart'; 

class  ParentsHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ParentHomePageTop(),
          ParentsHomeGridView()

      ],)

      
    );
  }
}

class ParentHomePageTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var name= "Nadika Poudel";
    var email= "nadikapoudel16@gmail.com";
    
    return Container(
      child: ListView(
        children: [
          ListTile(
            title: Text(name),
            subtitle: Text(email, style: TextStyle(color: Colors.black)),
            trailing:  TextButton(
              child:Text('View Profile',style: TextStyle(color: Colors.blue[800])), 
              onPressed: (){},), 
            leading: CircularImageContainer(),
            contentPadding: EdgeInsets.all(25),
            onLongPress: (){},


        ), 
        Divider(thickness: 25, color: Colors.grey), 
        ListTile(
          subtitle: Text("Logged in as Parent"), 
          trailing: Text('change',style: TextStyle(color: Colors.blue[800])))]
      )
      
    );
  }
}

class ParentsHomeGridView extends StatefulWidget {
  @override
  _ParentsHomeGridViewState createState() => _ParentsHomeGridViewState();
}

class _ParentsHomeGridViewState extends State<ParentsHomeGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.calendar_today),
                  TextButton(
                    child: Text("Manage Routine",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.perm_identity_rounded),
                  TextButton(
                    child: Text("Dependents",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.pending_actions),
                  TextButton(
                    child: Text("Tasks",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.library_books_outlined),
                  TextButton(
                    child: Text("Reports",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.auto_awesome),
                  TextButton(
                    child: Text("Rewards",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.picture_in_picture_sharp),
                  TextButton(
                    child: Text("Pecs",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.assignment_turned_in_outlined),
                  TextButton(
                    child: Text("Tutorial",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Icon(Icons.question_answer_sharp),
                  TextButton(
                    child: Text("Questions",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){})
                ],
                ),
            ) ),
            
        ],
        ),
    );

  }
}
