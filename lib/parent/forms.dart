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
      Text("Task name."),
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
      Text("Task Despcription."),
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
        child: Column(children: [
      Text("Date"),
      ListTile(
          title: Text("${taskDate.year}-${taskDate.month}-${taskDate.day}"),
          onTap: _pickDate,
          trailing: Icon(Icons.keyboard_arrow_down))
    ]));
  }

  Widget _buildInputTime() {
    return Container(
        child: Column(children: [
      Text("Time"),
      ListTile(
          title: Text("${taskTime.hour}-${taskTime.minute}"),
          onTap: _pickTime,
          trailing: Icon(Icons.keyboard_arrow_down))
    ]));
  }

  Widget _buildInputCompletion() {
    return Container(
        child: Column(children: [
      Text("Mark as completed?"),
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
          child: Text('+ Add Task'),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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

  Widget _buildInputPasscode() {
    return Container(
        child: Column(children: [
      Text("Enter Passcode(4-digit)"),
      TextFormField(
        controller: _passcodeController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (!value.isNotEmpty) {
            return "enter a passcode";
          }
          int intval = int.parse(value) ~/ 1000;
          if ((intval < 1) || (intval > 10)) {
            print(intval);
            return "enter a 4 digit passcode";
          }
          return null;
        },
      ),
    ]));
  }

  void _confirmAddDialog() {
    var dbase = Provider.of<DataBaseService>(_scaffoldKey.currentContext,
        listen: false);
    final snackBarAdd = SnackBar(
      content: Text('Adding the dependent..... Please Wait'),
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
                    Navigator.of(_scaffoldKey.currentContext).pop();
                    _scaffoldKey.currentState.showSnackBar(snackBarAdd);
                    //TODO:serverside
                    //variables already available
                  },
                )
              ],
            )
          ],
        ));
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
        children: [
          _buildInputName(),
          _buildInputRegCode(),
          _buildInputPasscode(),
          _submitForm()
        ],
      ),
    );
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
