import "package:flutter/material.dart";
import "package:flutter_tts/flutter_tts.dart";

FlutterTts flutterTts = FlutterTts();
speak(String text) async {
  String _text = text;
  await flutterTts.setLanguage("en US");
  await flutterTts.setPitch(1);
  await flutterTts.setVolume(1.0);
  await flutterTts.speak(_text);
}

class Toys extends StatefulWidget {
  @override
  _ToysState createState() => _ToysState();
}

// ignore: camel_case_types
class _ToysState extends State<Toys> {
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
                speak("I need" + _text);
              }),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2, children: [
      _cardContent('assets/aeroplane.jpg', "AEROPLANE"),
      _cardContent('assets/bike.jpg', "BIKE"),
      _cardContent('assets/bus.jpg', "BUS"),
      _cardContent('assets/doll.jpg', "DOLL"),
      _cardContent('assets/mobile.jpg', "MOBILE"),
      _cardContent('assets/tablet.jpg', "TABLET"),
      _cardContent('assets/tablet.jpg', "TABLET"),
      _cardContent('assets/tablet.jpg', "TABLET"),
    ]);
  }
}
