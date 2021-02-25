import 'package:easytalk/child/childHomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: camel_case_types
class IWant extends StatefulWidget {
  @override
  _IWantState createState() => _IWantState();
}

// ignore: camel_case_types
class _IWantState extends State<IWant> {
  Widget _cardContent(String path, String text) {
    String _text = text;
    String _path = path;
    return Container(
      child: InkWell(
          child: new Card(
            elevation: 10,
            child: Column(
              children: [
                Image(image: AssetImage(_path), height: 130, width: 130),
                Text(_text,
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ],
            ),
          ),
          onTap: () {
            speak("I want " + _text);
            print("I want" + _text);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: [
      _cardContent('assets/apple.jpg', "APPLE"),
      _cardContent('assets/banana.jpg', "BANANA"),
      _cardContent('assets/watermelon.jpg', "WATERMELON"),
      _cardContent('assets/milk.jpg', "MILK"),
      _cardContent('assets/litchi.jpg', "LITCHI"),
      _cardContent('assets/cake.jpg', "CAKE"),
      _cardContent('assets/chocolate.jpg', "CHOCOLATE"),
      _cardContent('assets/momo.jpg', "MOMO"),
    ]);
  }
}

Widget _cardContent(Widget icon, String text) {
  String _text = text;
  Widget _icon = icon;
  return Container(
      child: new Card(
    elevation: 10,
    child: Column(
      children: [
        _icon,
        Divider(thickness: 10, color: Colors.white),
        TextButton(
            child: Text(_text,
                style: TextStyle(fontSize: 20, color: Colors.black)),
            onPressed: () {
              speak("I am" + _text);
            })
      ],
    ),
  ));
}

class IAm extends StatefulWidget {
  @override
  _IAmState createState() => _IAmState();
}

class _IAmState extends State<IAm> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: [
      _cardContent(Icon(FontAwesomeIcons.angry, size: 90), "ANGRY"),
      _cardContent(Icon(FontAwesomeIcons.tired, size: 90), "TIRED"),
      _cardContent(Icon(FontAwesomeIcons.laughBeam, size: 90), "HAPPY"),
      _cardContent(Icon(FontAwesomeIcons.sadCry, size: 90), "CRYING"),
      _cardContent(Icon(FontAwesomeIcons.sadTear, size: 90), "SAD"),
      _cardContent(Icon(FontAwesomeIcons.surprise, size: 90), "SURPRISED"),
      _cardContent(Icon(FontAwesomeIcons.dizzy, size: 90), "DIZZY"),
      _cardContent(Icon(FontAwesomeIcons.grinHearts, size: 90), "LOVED")
    ]);
  }
}

class Greetings extends StatefulWidget {
  @override
  _GreetingsState createState() => _GreetingsState();
}

// ignore: camel_case_types
class _GreetingsState extends State<Greetings> {
  Widget _cardContent(String path, String text) {
    String _text = text;
    String _path = path;
    return Container(
        child: new Card(
      elevation: 10,
      child: Column(
        children: [
          Image(image: AssetImage(_path), height: 130, width: 130),
          TextButton(
              child: Text(_text,
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onPressed: () {
                speak(_text);
              }),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: [
      _cardContent('assets/hello.jpg', "HELLO"),
      _cardContent('assets/goodbye.jpg', "GOODBYE"),
      _cardContent('assets/good_morning.jpg', "GOOD MORNING"),
      _cardContent('assets/good_night.jpg', "GOOD NIGHT"),
      _cardContent('assets/thank_you.jpg', "THANK YOU"),
      _cardContent('assets/sorry.jpg', "SORRY"),
      _cardContent('assets/i_love_you.jpg', "I LOVE YOU"),
      _cardContent('assets/i_miss_you.jpg', "I MISS YOU"),
    ]);
  }
}

FlutterTts flutterTts = FlutterTts();
speak(String text) async {
  String _text = text;
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
  List<Widget> _widgetOptions = <Widget>[IWant(), IAm(), Greetings()];

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
            backgroundColor: Colors.red[300],
            title: CloseButton(
                color: Colors.white,
                onPressed: () {
                  ChildHomePage();
                }),
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
      ),
    );
  }
}
