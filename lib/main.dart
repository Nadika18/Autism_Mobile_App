import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'forms.dart';
import 'tasks.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO app',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Easytalk Autism'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildListViewItem(BuildContext context, index, List<QueryDocumentSnapshot> document){
    return ListTile(
        title: Row(
            children: [
              Expanded(
                  child:
                  Text(
                      document[index]['name'],
                      style:Theme.of(context).textTheme.headline5)
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white30,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: 
                  Text(
                      document[index]['registration_code'].toString(),
                      style:Theme.of(context).textTheme.headline6)
              ),
            ],
        ),
    );
  }

  Widget getDataFromFirebase(){
    return FutureBuilder(
            future: getData(),
            builder: (context,AsyncSnapshot<QuerySnapshot>
                snapshot){
              if(snapshot.connectionState ==
                  ConnectionState.done){
                return ListView.builder(
                    itemExtent: 80,
                    itemCount: snapshot.data.size,
                    itemBuilder: (context, index){
                      return _buildListViewItem(context,index,
                          snapshot.data.docs);
                    },
                );
              }
              else if (snapshot.connectionState ==
                  ConnectionState.none){
                return const Text('No data found');
              }
              return Center(
                  child: CircularProgressIndicator()
                  );
            },  
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
          itemExtent: 100,
          itemBuilder: (context, index){
            return _buildTodoListItem(index);
          },
        );
  }

  //change the state of main screen after returning back from a routed screen
  Future returnBack(dynamic value){
    setState(() {            
    });
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
                Navigator.push(context, MaterialPageRoute(
                          builder: (context) => BaseForm()
                        )).then(returnBack);
              },
            ),
    );
  }

  Future<QuerySnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("parents")
        .get();
  }
}
