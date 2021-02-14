import 'package:flutter/material.dart';
import 'utils.dart';
import 'tasks.dart';
import 'package:flutter_tts/flutter_tts.dart';


FlutterTts flutterTts = FlutterTts();
speak(String text)async{
  String _text= text;
  await flutterTts.setLanguage("en US");
  await flutterTts.setPitch(1);
  await flutterTts.setVolume(1.0);
  await flutterTts.speak(_text);

  }

var task_Name = "MAke your Bed";
var task_Description= "make it comfy to tuck yourself in";


class ChildHomePage extends StatefulWidget {
  ChildHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChildHomePageState createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  String name,gender;
  int age,tasks,remainingTasks;

  @override
  void initState(){
    super.initState();
    name = "Nadika";
    age = 19;
    gender = "Female";
    tasks = 18;
    remainingTasks = todoName.length;
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
                remainingTasks = todoName.length;
              });
            },
        )
    );
  }

  Widget _buildTodoList(){
    return ListView.builder(
        itemCount: todoName.length,
        itemBuilder: (context, index){
          return _buildTodoListItem(index);
        },
    );
  }

  Widget _hearTodaysStatus(){
    return InkWell(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: 
                BorderRadius.all(Radius.circular(5)),
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(Icons.campaign,size:40),
                  SizedBox(
                      width: 20,
                  ),
                  TextButton(child: Text("Hear todays status",
                      style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white)), onPressed: (){speak(task_Name + task_Description);})

                ]
            ), 
            ),
            onTap: (){
              print("tapped");
              //works okay
            },
            );
  }

  Widget _remainingTasks(){
    return InkWell(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: 
                BorderRadius.all(Radius.circular(5)),
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text(remainingTasks.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                      )
                  ),
                  SizedBox(
                      width: 20,
                  ),
                  Text("remaining tasks",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                      )
                  ),
                ]
                    ), 
                ),
                onTap: (){
                  print("tapped");
                  //works okay
                },
                );
  }

  Widget _currentTask(){
    return Container(
        decoration: BoxDecoration(
            borderRadius: 
            BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
              ),
            ],),
        child: Stack(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height*2 / 6.5,
                  child: Stack(
                      children: [
                        Positioned(
                            top:0,
                            width: MediaQuery.of(context).size.width * 0.55 - 3,
                            child:ClipRRect(
                                borderRadius:
                                BorderRadius.only(topLeft:Radius.circular(5)),
                                child: Image(
                                    image: AssetImage('assets/bed.jpg')
                                ))),
                        Positioned(
                            right:0,
                            width: MediaQuery.of(context).size.width * 0.45 - 3,
                            height: MediaQuery.of(context).size.height*1.8 / 6.5,
                            child:Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Text(task_Name,
                                      style:
                                      TextStyle(
                                          fontSize: 16,
                                          fontWeight:FontWeight.bold
                                          ),
                                      textAlign: TextAlign.center,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(15),
                                      child:Text(task_Description,
                                          textAlign: TextAlign.center,
                                      )
                                  ),
                                ],
                            )),
                            ],
                            )),

                            Positioned(
                                bottom:0,
                                width: MediaQuery.of(context).size.width -6,
                                child:Container(
                                    decoration: BoxDecoration(
                                        borderRadius: 
                                        BorderRadius.only(bottomLeft:Radius.circular(5),bottomRight:Radius.circular(5)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(0.3),
                                              spreadRadius: 7,
                                              blurRadius: 7,
                                              offset: Offset(0, -3),
                                          ),
                                        ],),
                                    padding: const EdgeInsets.fromLTRB(0,3,0,5),
                                    child:
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.audiotrack,size:30),
                                          Icon(Icons.add),
                                          Icon(Icons.check_box_rounded),
                                        ],
                                    ))),
                                    ]),
                                    );
  }

  Widget _feelings (){
    return Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.mood,size:50),
                      onPressed: (){
                      }
                      ),
                  Text("How are you feeling",style: TextStyle(fontSize:20))
                ],
              ),
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
            child: Stack(
                children: [Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width,
                              minHeight: 70,
                              maxHeight: 70,
                          ),
                          child: _createTopView(),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(3,4,3,0),
                          height: (MediaQuery.of(context).size.height-70)/6.5,
                          child: _hearTodaysStatus(),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(3,4,3,0),
                          height: (MediaQuery.of(context).size.height-70)/6.5,
                          child: _remainingTasks(),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(3,4,3,0),
                          height: (MediaQuery.of(context).size.height-70)*2.5/6.5,
                          child: _currentTask(),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(3,13,3,0),
                          child: _feelings(),
                          ),
                      Expanded(
                          child:_buildTodoList(),
                      ),
                      ])
                          ]),
                          ));
  }
}

