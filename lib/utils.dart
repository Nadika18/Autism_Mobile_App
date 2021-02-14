import "package:flutter/material.dart";

Widget CircularImageContainer(String location,double size) {
  double _size = size;
  return Center(
      child: new Container(
          width: _size,
          height: _size,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage(
                      location )
              )
          )
      ),
  );
}
Widget CircularImageContainerLink(String location,double size) {
  double _size = size;
  return Center(
      child: new Container(
          width: _size,
          height: _size,
          decoration: new BoxDecoration(
              shape: BoxShape.circle,
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                      location )
              )
          )
      ),
  );
}
