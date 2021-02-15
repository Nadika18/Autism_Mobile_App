import "package:flutter/material.dart";

Widget circularImageContainer(String location, double size) {
  double _size = size;
  return Center(
    child: new Container(
        width: _size,
        height: _size,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover, image: new AssetImage(location)))),
  );
}

Widget circularImageContainerLink(String location, double size) {
  double _size = size;
  return Center(
    child: new Container(
        width: _size,
        height: _size,
        decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
                fit: BoxFit.cover, image: new NetworkImage(location)))),
  );
}
