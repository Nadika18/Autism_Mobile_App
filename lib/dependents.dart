import 'package:flutter/material.dart';
class Dependents extends StatefulWidget {
  @override
  _DependentsState createState() => _DependentsState();
}

class _DependentsState extends State<Dependents> {
  
  Widget _buildList() => Column(children:
  [
    _tile('Nadika Poudel', 'Female, 19 years old','assets/nadika.jpg',"7","8"),

        _tile('Krishbin Paudel', 'Male, 19 years old', 'assets/krishbin.jpg',"7","8"),
        _tile('Pramish Paudel', 'Male, 20 years old', 'assets/pramish.jpg',"7","8"),
        _tile("Oshan Poudel", "Male, 4 years old", "assets/oshan.jpg","7","8")
        
      ],
       
    );
  
    

 Widget _searchBar() => Padding(
   padding: const EdgeInsets.all(8),
   child: TextField(
     decoration: InputDecoration(
       hintText: "Search for dependents.."
     ),
     onChanged: (text){
       text= text.toLowerCase();
       setState(() {
         
       });
     },
     ),

 );

 

Card _tile(String title, String subtitle, String imagepath, String routines, String awards) => Card(
  margin: EdgeInsets.all(20),
  child: Column(children:[ListTile(
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        ),
       
      
      onPressed: () {},
      
      child: Image(image:AssetImage(imagepath))
    ),
     hoverColor: Colors.blue,
     contentPadding: EdgeInsets.all(6)), 
     Divider(),
      Container(
        child: Text(
          routines+" routines, "+awards+" awards",
          style: TextStyle(color: Colors.grey) ,),)]
    ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:Icon(Icons.keyboard_arrow_left_sharp , 
          color: Colors.black, size: 45), 
        onPressed: (){}), 
        title: Text("Search Dependent", style: TextStyle(color:Colors.black),)
      ),
      body: Container(
      child: Card(
        margin:EdgeInsets.all(12),
        child:Column(children:[_searchBar(),_buildList()])))



      
    );
  }
}