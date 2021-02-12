import 'package:flutter/material.dart';
import './circleimage.dart'; 


class ChildHomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Text name= Text('Nadika');
    Text age= Text('19');
    Text gender= Text('Female');
    var tasks='18';
    Widget myDetailContainer= Container(
      child:Column(
        children:[Text('Make your Bed', 
        style: TextStyle(
    fontSize: 120)),
    Container(height:40),
    Text("7:00 am", 
    style: TextStyle(
    fontSize: 120, 
    fontWeight: FontWeight.bold)),
    Container(height: 200),
    Text("Fold them properly and get extra sheets", 
    style: TextStyle(
    fontSize: 80)) ]));
    
    Widget latestTask= Container(child: FittedBox(child: 
    
    Material(color:Colors.white, elevation:14.0,borderRadius:BorderRadius.circular(30.0),shadowColor:Colors.grey  ,child: Row(children: [
      Container(child: ClipRRect(borderRadius:new BorderRadius.circular(14.0),child:Image(image: AssetImage('assets/bed.jpg')) )), 
    Container(
      child:myDetailContainer,
       width: 1100)]),
       
       )));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EasyTalk_Autism',
      theme: ThemeData(primaryColor: Colors.white),
      home: Scaffold(
        appBar: AppBar(title: CircleImage(), centerTitle: true, actions: [name,age,gender]),
        body: Column( children:[Container(
  constraints: BoxConstraints.expand(
    height: Theme.of(context).textTheme.headline4.fontSize * 1 + 90.0,
  ),
  padding: const EdgeInsets.all(8.0),
  color: Colors.blue[600],
  alignment: Alignment.center,
  child: Row(children:[Icon(Icons.campaign),Text("Hear todays status",
    style: Theme.of(context)
        .textTheme
        .headline6
        .copyWith(color: Colors.white))
  
        ]), ),
        Container(
  constraints: BoxConstraints.expand(
    height: Theme.of(context).textTheme.headline4.fontSize * 1 + 90.0,
  ),
  padding: const EdgeInsets.all(8.0),
  color: Colors.orange,
  alignment: Alignment.center,
  child: Column(children:[Text(tasks,style: Theme.of(context)
        .textTheme
        .headline3
        .copyWith(color: Colors.white) ),
        Text("Tasks remaining",style: Theme.of(context).textTheme
        .headline5
        .copyWith(color: Colors.white))
  
         ])), 
         
         latestTask])


      ));
}}



