import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
        ),
        body: 
        FutureBuilder(
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
