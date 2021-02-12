import "package:flutter/material.dart";
import 'tasks.dart';

class BaseForm extends StatefulWidget{
  @override
  _BaseFormState createState() => _BaseFormState();
}

class _BaseFormState extends State<BaseForm>{
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final title = "enter a todo";
  var taskName;
  var taskDescription;
  DateTime taskDate;
  TimeOfDay taskTime;
  bool selected;

  @override
  void initState(){
    super.initState();
    selected = false;
    taskDate = DateTime.now();
    taskTime = TimeOfDay.now();
  }

  void _selectFormRadioButton(bool value){
    setState(() {            
      selected = value;
    });
  }

  SnackBar snackbar(String text,Duration dur){
    return SnackBar(content: Text(text),duration: dur,);
  }


  Future<void> _pickDate() async{
    DateTime date = await showDatePicker(
        context: _scaffoldKey.currentContext,
        firstDate: DateTime.now().subtract( Duration(days: 30)),
        lastDate: DateTime.now().add( Duration(days: 30)),
        initialDate: DateTime.now(),
        );
    if (date != null){
      setState(() {                
        taskDate = date;
      });
      _scaffoldKey.currentState.showSnackBar(
          snackbar("Date Selected",Duration(milliseconds:1000)));
    }else{
      _scaffoldKey.currentState.showSnackBar(
          snackbar("Cancelled",Duration(milliseconds:500)));
    }
  }

  Future<void> _pickTime() async{
    TimeOfDay time = await showTimePicker(
        context: _scaffoldKey.currentContext,
        initialTime:TimeOfDay.now(),
        );
    if (time != null){
      setState(() {                
        taskTime = time;
      });
      _scaffoldKey.currentState.showSnackBar(
          snackbar("Date Selected",Duration(milliseconds:1000)));
    }else{
      _scaffoldKey.currentState.showSnackBar(
          snackbar("Cancelled",Duration(milliseconds:500)));
    }
  }

  Widget _buildInputName(){
    return Container(
          child: Column(
                children: [
                  Text("Task name."),
                  TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "enter a task name";
                        }
                        taskName = value;
                        return null;
                      },
                      ),
                ]
              )
        );
  }

  Widget _buildInputDespcription(){
    return Container(
          child: Column(
                children: [
                  Text("Task Despcription."),
                  TextFormField(
                      validator: (value){
                        if(value.isEmpty){
                          return "enter a task despcription";
                        }
                        taskDescription = value;
                        return null;
                      },
                      ),
                ]
              )
        );
  }

  Widget _buildInputDate(){
    return Container(
          child: Column(
                children: [
                  Text("Date"),
                  ListTile(
                      title:
                      Text("${taskDate.year}-${taskDate.month}-${taskDate.day}"),
                      onTap: _pickDate, 
                      trailing: Icon(Icons.keyboard_arrow_down)
                      )
                ]
              )
        );
  }

  Widget _buildInputTime(){
    return Container(
          child: Column(
                children: [
                  Text("Time"),
                  ListTile(
                      title:
                      Text("${taskTime.hour}-${taskTime.minute}"),
                      onTap: _pickTime, 
                      trailing: Icon(Icons.keyboard_arrow_down)
                      )
                ]
              )
        );
  }

  Widget _buildInputCompletion(){
    return Container(
          child: Column(
                children: [
                  Text("Mark as completed?"),
                  ButtonBar(
                      alignment: MainAxisAlignment.center,
                        children: [
                          Text("Yes"),
                          Radio(
                              value: true,
                              groupValue: selected,
                              onChanged: (val){
                                _selectFormRadioButton(val);
                              }
                              ),
                          Text("No"),
                          Radio(
                              value: false,
                              groupValue: selected,
                              activeColor: Colors.red,
                              onChanged: (val){
                                _selectFormRadioButton(val);
                              }
                              ),
                        ],
                      ),
                ]
              )
        );
  }

  Widget _submitForm(){
    final snackBar = SnackBar(content: Text('Adding the task.....'));
    return Container(
          child: Align(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                    child: Text('+ Add Task'),
                    onPressed: (){
                      if (_formKey.currentState.validate()){
                        addTodo(taskName,taskDescription,taskDate,selected);
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                      Navigator.of(_scaffoldKey.currentContext).pop();
                      //serverside
                      //variables already available
                      }
                    },
                    ),
              ),
        );
  }

  Widget _buildForm(){
    return Form(
          key: _formKey,
          child: Column(
                children: [
                  _buildInputName(),
                  _buildInputDespcription(),
                  _buildInputDate(),
                  _buildInputTime(),
                  _buildInputCompletion(),
                  _submitForm()
                ],
              ),
        );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
              title: Text(title),
            ),
        body: _buildForm()
        );
  }
}
