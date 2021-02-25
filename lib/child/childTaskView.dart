import 'package:easytalk/parent/forms.dart';
import 'package:easytalk/services/models/tasks.dart';
import 'package:easytalk/utils/customWidgets.dart';
import 'package:flutter/material.dart';

class ChildTaskView extends StatefulWidget {
  final String uid;
  ChildTaskView({@required this.uid});
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<ChildTaskView> {
  String uid;
  @override
  void initState() {
    super.initState();
    uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildTaskListItem(int index) {
      return Card(margin:EdgeInsets.all(8),
      child: ListTile(
          leading: Text((index + 1).toString()),
          title: Text(todoName[index], style: TextStyle( fontSize: 18)),
          subtitle: Text(todoDesp[index]),
          trailing: FlatButton(
            child: Icon(Icons.delete),
            onPressed: () {
              setState(() {});
            },
          )));
    }

    Widget _buildTaskList() {
      return Container(
          height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.all(5),
          child: Card(
              elevation: 10,
              child: Column(children: [
                ListTile(
                  leading:
                      circularImageContainerNoAlign("assets/nadika.jpg", 40),
                  title: Text("Nadika Poudel"),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => TaskForm(uid: "jfkd")));
                    },
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: todoName.length,
                  itemBuilder: (context, index) {
                    return _buildTaskListItem(index);
                  },
                )),
              ])));
    }

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
      body: Container(
        child: _buildTaskList(),
      ),
    );
  }
}


