import "package:flutter/material.dart";
import 'package:flutter_tts/flutter_tts.dart';
FlutterTts flutterTts = FlutterTts();
speak(String text)async{
  String _text= text;
  await flutterTts.setLanguage("en US");
  await flutterTts.setPitch(1);
  await flutterTts.setVolume(1.0);
  await flutterTts.speak(_text);

  }

Widget Cards_Content3(String path, String text) {
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
                    onPressed: (){speak( "I need"+_text);}),
                ],
                ),
            ) );
}
class Toys extends StatefulWidget {
  @override
 _ToysState createState() => _ToysState();
}

// ignore: camel_case_types
class _ToysState extends State<Toys> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: [ Cards_Content3('assets/aeroplane.jpg', "AEROPLANE")
          ,Cards_Content3('assets/bike.jpg', "BIKE"),
          Cards_Content3('assets/bus.jpg', "BUS"),
          Cards_Content3('assets/doll.jpg', "DOLL"),
          Cards_Content3('assets/mobile.jpg', "MOBILE"),
          Cards_Content3('assets/tablet.jpg', "TABLET"),
          Cards_Content3('assets/tablet.jpg', "TABLET"),
          Cards_Content3('assets/tablet.jpg', "TABLET"),
          

            ]
            ) ;
  }
}