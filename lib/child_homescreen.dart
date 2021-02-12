import 'package:flutter/material.dart';
import 'forms.dart';
import 'tasks.dart';


class ChildHomePage extends StatefulWidget {
  ChildHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _ChildHomePageState createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
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
          itemExtent: 100,
          itemBuilder: (context, index){
            return _buildTodoListItem(index);
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
        ),
        body: _buildTodoList(),
        floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => BaseForm(),
                        )
                    ).then((value) => setState((){}));
              }
            ),
    );
  }
}
