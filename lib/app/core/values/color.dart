import 'package:flutter/cupertino.dart';

class ToDoColor{
  static const _pink = Color(0xffFFC0CB);
  static const _purple = Color(0xff800080);
  static const _deepPink = Color(0xffFF1493);
  static const _green = Color(0xff008000);
  static const _yellow = Color.fromARGB(255, 204, 204, 77);
  static const _blue = Color.fromARGB(255, 34, 201, 173);
  static const _darkbrown = Color(0xFF5C4033);

  static const Map<String,Color> iconColors = {
    "Personal" : _purple,
    "Work" : _pink,
    "Movie to watch" : _green,
    "Sport" : _yellow,
    "Travel" : _deepPink,
    "Shop" : _blue,
    "Game" : _darkbrown
  };
}