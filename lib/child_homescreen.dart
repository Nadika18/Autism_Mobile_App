import 'package:flutter/material.dart';
import 'utils.dart';
import 'tasks.dart';


class ChildHomePage extends StatefulWidget {
  ChildHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChildHomePageState createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  String name,gender;
  int age,tasks;

  @override
  void initState(){
    super.initState();
    name = "Nadika";
    age = 19;
    gender = "Female";
    tasks = 18;
  }

  Widget taskMaker(String taskName, String
      taskDescription,DateTime dtime){ 
    return Container(
        child:Column(
            children:[
              Text(taskName, 
                  style: TextStyle(
                      fontSize: 120)
              ),
              Container(height:40),
              Text(dtime.hour.toString(), 
                  style: TextStyle(
                      fontSize: 120, 
                      fontWeight: FontWeight.bold)
              ),
              Container(height: 200),
              Text(taskDescription, 
                  style: TextStyle(
                      fontSize: 80)
              ) 
            ]
        )
    );
  }

  Widget _buildTodoListItem(int index){
    return ListTile(
        leading: Text((index+1).toString()),
        title: Text(todoName[index]),
        subtitle: Text(todoDesp[index]),
        trailing: FlatButton(
            child: Icon(Icons.delete),
            onPressed: (){
              setState(() {                          
                removeTodo(index);
              });
            },
        )
    );
  }

  Widget _buildTodoList(){
    return ListView.builder(
        itemCount: todoName.length,
        itemBuilder: (context, index){
          return
              taskMaker(taskName[index],taskDescription[index],dateTime[index]);
        },
    );
  }

  Widget _createTopView(){
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
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
                  onPressed: (){
                  },
              ),
              CircularImageContainer("assets/nadika.jpg",55.0),
              Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(name),
                        Text("$gender $age")
                      ]
                  ),
              )
            ]
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:[
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width,
                          minHeight: 60,
                          maxHeight: 80,
                      ),
                      child:Expanded(
                          child: _createTopView(),
                      ),
                  ),
                  Expanded(
                      child:_buildTodoList()
                  ),
                ])
        ),
    );
  }
}
