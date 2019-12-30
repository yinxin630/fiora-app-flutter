import 'dart:math';

import 'package:flutter/material.dart';

class ProfileClipper extends CustomClipper<Rect> {

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: Offset(size.width /2, size.height / 2),
      radius: min(size.width, size.height) / 2,
    );
  }
  
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}