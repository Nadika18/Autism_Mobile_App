import 'package:easytalk/child_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';

Widget Cards_Content(String path, String text) {
  String _text= text;
  String _path= path;
  return Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Image(image: AssetImage(_path),height: 130, width: 130),
                  TextButton(
                    child: Text(_text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){speak("I want" + _text);}),
                ],
                ),
            ) );
}

// ignore: camel_case_types
class I_want extends StatefulWidget {
  @override
  _I_wantState createState() => _I_wantState();
}

// ignore: camel_case_types
class _I_wantState extends State<I_want> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: [ Cards_Content('assets/apple.jpg', "APPLE")
          ,Cards_Content('assets/banana.jpg', "BANANA"),
          Cards_Content('assets/watermelon.jpg', "WATERMELON"),
          Cards_Content('assets/milk.jpg', "MILK"),
          Cards_Content('assets/litchi.jpg', "LITCHI"),
          Cards_Content('assets/cake.jpg', "CAKE"),
          Cards_Content('assets/chocolate.jpg', "CHOCOLATE"),
          Cards_Content('assets/momo.jpg', "MOMO"),

            ]
            ) ;
  }
}

Widget Cards_Content1(Widget icon, String text) {
  String _text= text;
  Widget _icon= icon;
  return Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  _icon,
                  Divider(thickness: 10,color: Colors.white),
                  TextButton(
                    child: Text(_text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){speak("I am" + _text);})
                ],
                ),
            ) );
}


class I_am extends StatefulWidget {
  @override
  _I_amState createState() => _I_amState();
}

class _I_amState extends State<I_am> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: [ Cards_Content1(Icon(FontAwesomeIcons.angry, size: 90), "ANGRY")
          ,Cards_Content1(Icon(FontAwesomeIcons.tired, size: 90), "TIRED"),
          Cards_Content1(Icon(FontAwesomeIcons.laughBeam, size: 90), "HAPPY"),
          Cards_Content1(Icon(FontAwesomeIcons.sadCry, size: 90), "CRYING"),
          Cards_Content1(Icon(FontAwesomeIcons.sadTear, size: 90), "SAD"),
          Cards_Content1(Icon(FontAwesomeIcons.surprise, size: 90), "SURPRISED"),
          Cards_Content1(Icon(FontAwesomeIcons.dizzy, size: 90), "DIZZY"),
          Cards_Content1(Icon(FontAwesomeIcons.grinHearts, size: 90), "LOVED")
            ]
            ) ;
  }
}
Widget Cards_Content2(String path, String text) {
  String _text= text;
  String _path= path;
  return Container(
            child: new Card(
              elevation: 10,
              child: Column(
                children: [
                  Image(image: AssetImage(_path),height: 130, width: 130),
                  TextButton(
                    child: Text(_text,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                    )), 
                    onPressed: (){speak( _text);}),
                ],
                ),
            ) );
}
class Greetings extends StatefulWidget {
  @override
  _GreetingsState createState() => _GreetingsState();
}

// ignore: camel_case_types
class _GreetingsState extends State<Greetings> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: [ Cards_Content2('assets/hello.jpg', "HELLO")
          ,Cards_Content2('assets/goodbye.jpg', "GOODBYE"),
          Cards_Content2('assets/good_morning.jpg', "GOOD MORNING"),
          Cards_Content2('assets/good_night.jpg', "GOOD NIGHT"),
          Cards_Content2('assets/thank_you.jpg', "THANK YOU"),
          Cards_Content2('assets/sorry.jpg', "SORRY"),
          Cards_Content2('assets/i_love_you.jpg', "I LOVE YOU"),
          Cards_Content2('assets/i_miss_you.jpg', "I MISS YOU"),

            ]
            ) ;
  }
}



FlutterTts flutterTts = FlutterTts();
speak(String text)async{
  String _text= text;
  await flutterTts.setLanguage("en US");
  await flutterTts.setPitch(1);
  await flutterTts.setVolume(1.0);
  await flutterTts.speak(_text);

  }



class ChildPecs extends StatefulWidget {
  ChildPecs({Key key}) : super(key: key);
  @override
  _ChildPecsState createState() => _ChildPecsState();
}

class _ChildPecsState extends State<ChildPecs> {
  FlutterTts flutterTts = FlutterTts();

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    
    I_want(), I_am(), Greetings()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // here the desired height
          child: AppBar(
        backgroundColor:Colors.red[300], 
        title: CloseButton(
          color: Colors.white, 
          onPressed:(){ ChildHomePage();} 
          ) ,
          centerTitle: true,
         )),
        body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_rounded),
              label: "I want",
              
            ),
            
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_emotions),
              label: "I am",
              
            ), 
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.grinHearts),
              label: "Greetings",
              
            ),
             
            ],
            currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
            
            ) ,
      );
      
    
  }
}


 