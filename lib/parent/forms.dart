import 'package:easytalk/services/firebase/databaseservice.dart';
import "package:flutter/material.dart";
import 'package:easytalk/services/models/tasks.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatefulWidget {
  final String uid;
  TaskForm({@required this.uid});
  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String uid;
  final title = "enter a todo";
  var taskName;
  var taskDescription;
  DateTime taskDate;
  TimeOfDay taskTime;
  bool selected;

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    selected = false;
    taskDate = DateTime.now();
    taskTime = TimeOfDay.now();
  }

  void _selectFormRadioButton(bool value) {
    setState(() {
      selected = value;
    });
  }

  SnackBar snackbar(String text, Duration dur) {
    return SnackBar(
      content: Text(text),
      duration: dur,
    );
  }

  Future<void> _pickDate() async {
    DateTime date = await showDatePicker(
      context: _scaffoldKey.currentContext,
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now().add(Duration(days: 30)),
      initialDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        taskDate = date;
      });
      _scaffoldKey.currentState.showSnackBar(
          snackbar("Date Selected", Duration(milliseconds: 1000)));
    } else {
      _scaffoldKey.currentState
          .showSnackBar(snackbar("Cancelled", Duration(milliseconds: 500)));
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay time = await showTimePicker(
      context: _scaffoldKey.currentContext,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        taskTime = time;
      });
      _scaffoldKey.currentState.showSnackBar(
          snackbar("Date Selected", Duration(milliseconds: 1000)));
    } else {
      _scaffoldKey.currentState
          .showSnackBar(snackbar("Cancelled", Duration(milliseconds: 500)));
    }
  }

  Widget _buildInputName() {
    return Container(
        child: Column(children: [
      Align(alignment: Alignment.centerLeft ,child:Text("Enter the task", style: TextStyle(fontSize:18 ))),
      TextFormField(
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value.isEmpty) {
            return "enter a task name";
          }
          taskName = value;
          return null;
        },
      ),
    ]));
  }

  Widget _buildInputDespcription() {
    return Container(
        child: Column(children: [
      Align(alignment: Alignment.centerLeft ,child:Text("Enter task Despcription.",style: TextStyle(fontSize:18 ))),
      TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "enter a task despcription";
          }
          taskDescription = value;
          return null;
        },
      ),
    ]));
  }

  Widget _buildInputDate() {
    return Container(
        child: Column(children: [Align(alignment: Alignment.centerLeft ,child:
      Text("Date", style: TextStyle(fontSize:18 ))),
      ListTile(
          title: Text("${taskDate.year}-${taskDate.month}-${taskDate.day}",style: TextStyle(fontSize:18 )),
          onTap: _pickDate,
          trailing: Icon(Icons.keyboard_arrow_down))
    ]));
  }

  Widget _buildInputTime() {
    return Container(
        child: Column(children: [
          Align(alignment: Alignment.centerLeft ,child:
      Text("Time", style: TextStyle(fontSize:18))),
      ListTile(
          title: Text("${taskTime.hour}-${taskTime.minute}", style: TextStyle(fontSize:18 )),
          onTap: _pickTime,
          trailing: Icon(Icons.keyboard_arrow_down))
    ]));
  }

  Widget _buildInputCompletion() {
    return Container(
        child: Column(children: [
          
      Text("Mark as completed?",style: TextStyle(fontSize:18 )),
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          Text("Yes"),
          Radio(
              value: true,
              groupValue: selected,
              onChanged: (val) {
                _selectFormRadioButton(val);
              }),
          Text("No"),
          Radio(
              value: false,
              groupValue: selected,
              activeColor: Colors.red,
              onChanged: (val) {
                _selectFormRadioButton(val);
              }),
        ],
      ),
    ]));
  }

  Widget _submitForm() {
    final snackBar = SnackBar(content: Text('Adding the task.....'));
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: RaisedButton(
          child: Text('+ Add Task', style: TextStyle(fontSize:18 )),
          onPressed: () {
            if (_formKey.currentState.validate()) {
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

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Container(child: ListView(
        padding:EdgeInsets.all(10) ,
        
        children: [
          _buildInputName(),
          Divider(color: Colors.white,thickness: 15),
          _buildInputDespcription(),
          Divider(color: Colors.white,thickness: 15),
          _buildInputDate(),
          Divider(color: Colors.white,thickness: 15),
          _buildInputTime(),
          Divider(color: Colors.white,thickness: 15),
          _buildInputCompletion(),
          Divider(color: Colors.white,thickness: 15),
          _submitForm()
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_sharp,
                color: Colors.black, size: 45),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.black),
        ));
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: appBar,
        body: _buildForm());
  }
}

class DependentForm extends StatefulWidget {
  @override
  _DependentFormState createState() => _DependentFormState();
}

class _DependentFormState extends State<DependentForm> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _regcodeController = TextEditingController();
  TextEditingController _passcodeController = TextEditingController();
  String uid;
  final title = "Create a new dependent";
  void _confirmAddDialog() {
    var dbase = Provider.of<ParentDataBaseService>(context, listen: false);
    final snackBarAdd = SnackBar(
      content: Text('Adding the dependent..... Please Wait'),
      duration: Duration(milliseconds: 1000),
    );
    final snackBarAllocated = SnackBar(
      content: Text('Registration Code allocated please use another'),
      duration: Duration(milliseconds: 1000),
    );
    final snackBarSuccess = SnackBar(
      content: Text('Dependent added.'),
      duration: Duration(milliseconds: 1000),
    );
    final snackBarCancel = SnackBar(
      content: Text('Cancelled.....'),
      duration: Duration(milliseconds: 500),
    );
    showDialog(
        context: _scaffoldKey.currentContext,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(15),
          title: Text("Are you sure you want to add dependent?"),
          actions: [
            Text(
                "This registration code will be occupied for your child if it is available and you cannot modify it."),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(_scaffoldKey.currentContext).pop();
                    _scaffoldKey.currentState.showSnackBar(snackBarCancel);
                  },
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () async {
                    _scaffoldKey.currentState.showSnackBar(snackBarAdd);
                    var exists = await dbase
                        .checkDependentExists(_regcodeController.text);
                    if (!exists) {
                      dbase
                          .addDependent(
                              _nameController.text, _regcodeController.text)
                          .then((_) => _scaffoldKey.currentState
                              .showSnackBar(snackBarSuccess))
                          .catchError((e) => print(e));
                    } else {
                      _scaffoldKey.currentState.showSnackBar(snackBarAllocated);
                    }
                    ;
                    Navigator.of(_scaffoldKey.currentContext).pop();
                  },
                )
              ],
            )
          ],
        ));
  }

  @override
  Widget _buildInputName() {
    return Container(
        child: Column(children: [
      Text("Child Name."),
      TextFormField(
        controller: _nameController,
        textInputAction: TextInputAction.next,
        autofocus: true,
        validator: (value) {
          if (value.isEmpty) {
            return "enter the child name";
          }
          return null;
        },
      ),
    ]));
  }

  Widget _buildInputRegCode() {
    return Container(
        child: Column(children: [
      Text("Enter Registration code(6-digit)"),
      TextFormField(
        textInputAction: TextInputAction.next,
        controller: _regcodeController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (!value.isNotEmpty) {
            return "enter registration code";
          }
          int intval = int.parse(value) ~/ 100000;
          if ((intval < 1) || (intval > 10)) {
            print(intval);
            return "The length of the code is incorrect";
          }
          return null;
        },
      ),
    ]));
  }

  void snack(String text, Duration dur) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text(text), duration: dur));
  }

  Widget _submitForm() {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: RaisedButton(
          child: Text('+ Add Dependent'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _confirmAddDialog();
            }
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildInputName(), _buildInputRegCode(), _submitForm()],
      ),
    );
  }

  Widget build(BuildContext context) {
    var appBar = AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left_sharp,
                color: Colors.black, size: 45),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          "Add Dependent",
          style: TextStyle(color: Colors.black),
        ));
    return SafeArea(
        child: LayoutBuilder(
            builder: (context, constraints) => Scaffold(
                key: _scaffoldKey,
                resizeToAvoidBottomInset: false,
                appBar: appBar,
                body: SingleChildScrollView(
                    child: Container(
                        height:
                            constraints.maxHeight - appBar.preferredSize.height,
                        child: _buildForm())))));
  }
}
