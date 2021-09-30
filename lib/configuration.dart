import 'package:flutter/cupertino.dart';

class ColorSchema {
  static const Color deepBlue = Color(0xff635570);
  static const Color deepSeaBlue = Color(0xff1795C2);
  static const Color inputFieldFillColor = Color(0xfff3f3f4);
  static const List<Color> gradientColor = <Color>[
    Color(0xff635570),
    Color(0xff1795C2)
  ];
}

class Responsive {
  final Size? size;
  final double? height;
  final double? width;
  final double? aspectRatio;
  Responsive({
    this.size,
    this.height,
    this.width,
    this.aspectRatio,
  });
}



