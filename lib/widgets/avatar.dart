import 'package:flutter/material.dart';

import '../utils/profileClipper.dart';

class Avatar extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  Avatar({
    @required this.url,
    @required this.width,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: ProfileClipper(),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
