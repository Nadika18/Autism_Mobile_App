import 'package:easytalk/child/childHomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Feelings extends StatefulWidget {
  @override
  _IAmState createState() => _IAmState();
}

class _IAmState extends State<Feelings> {
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
      body: Center(child:
    GridView.count(crossAxisCount: 2, children: [
      _cardContent(Icon(FontAwesomeIcons.angry, size: 90), "ANGRY"),
      _cardContent(Icon(FontAwesomeIcons.tired, size: 90), "TIRED"),
      _cardContent(Icon(FontAwesomeIcons.laughBeam, size: 90), "HAPPY"),
      _cardContent(Icon(FontAwesomeIcons.sadCry, size: 90), "CRYING"),
      _cardContent(Icon(FontAwesomeIcons.sadTear, size: 90), "SAD"),
      _cardContent(Icon(FontAwesomeIcons.surprise, size: 90), "SURPRISED"),
      _cardContent(Icon(FontAwesomeIcons.dizzy, size: 90), "DIZZY"),
      _cardContent(Icon(FontAwesomeIcons.grinHearts, size: 90), "LOVED")
    ])));
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

