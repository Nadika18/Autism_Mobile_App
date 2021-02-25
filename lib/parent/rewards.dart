import "package:flutter/material.dart";

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  String star1= "5";
  String star2="10";

  Widget task(String rewardName, String imagepath, String time, String stars){
  return Card(
    margin: EdgeInsets.all(6),
    child:Column(
        children: [
          Text(rewardName, style:TextStyle( fontSize: 20)),
          Image(image: AssetImage(imagepath), height: 130, width: 130),
          Text('On '+ time),
          Text("Will get "+ stars + " stars", style:TextStyle( color: Colors.grey))

          
              
        ],
      ) );
}
Widget gridView(){
  return GridView.count(crossAxisCount: 2,
  children: [task("Apple",'assets/apple.jpg',"5 pm",star1),task("Cake","assets/cake.jpg","6 pm",star2)],
  );
}

  @override
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
          title: Text("Rewards", style:TextStyle(color: Colors.black) ,)
    ),
    body: gridView());
    
  }
}