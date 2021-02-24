import "package:flutter/material.dart";

class ManageRoutine extends StatefulWidget {
  @override
  _ManageRoutineState createState() => _ManageRoutineState();
}

class _ManageRoutineState extends State<ManageRoutine> with SingleTickerProviderStateMixin {
  TabController controller;
  String taskName= "Make Bed";
  String time= "5 pm";
  String imagepath= "assets/bed.jpg";
  String stars= "5";
  @override

  
void initState(){
  controller = new TabController(length: 7, vsync: this);
  super.initState();
}
@override
void dispose(){
  controller.dispose();
  super.dispose();
}

Widget task(String taskName, String imagepath, String time, String stars){
  return Card(
    margin: EdgeInsets.all(6),
    child:Column(
        children: [
          Text(taskName, style:TextStyle( fontSize: 20)),
          Image(image: AssetImage(imagepath), height: 130, width: 130),
          Text('On '+ time),
          Text("Will get "+ stars + " stars", style:TextStyle( color: Colors.grey))

          
              
        ],
      ) );
}
Widget gridView(String taskName, String imagepath, String time, String stars){
  return GridView.count(crossAxisCount: 2,
  children: [task(taskName,imagepath,time,stars),task(taskName,imagepath,time,stars)],
  );
}




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left_sharp,
                  color: Colors.black, size: 45),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Column(children:[Text(
            "Routine",
            style: TextStyle(color: Colors.black),
          ),Text("Nadika Poudel")]),
          bottom: new TabBar(
            indicatorWeight: 5,
            
            controller: controller,
            isScrollable: true,
            tabs: [
              new Tab(child: new Text("Sunday", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
              new Tab(child: new Text("Monday",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
              new Tab(child: new Text("Tuesday", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
              new Tab(child: new Text("Wednesday",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
              new Tab(child: new Text("Thursday",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
              new Tab(child: new Text("Friday",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
              new Tab(child: new Text("Saturday",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),),
            ],
          ),
          ),
      body: new TabBarView(
        controller: controller,
        children: [ 
          gridView(taskName, imagepath, time,stars),
          gridView(taskName, imagepath, time,stars),
           gridView(taskName, imagepath, time,stars),
            gridView(taskName, imagepath, time,stars),
             gridView(taskName, imagepath, time,stars),
              gridView(taskName, imagepath, time,stars),
               gridView(taskName, imagepath, time,stars),

           

        ]
        ,)
    );}
}



