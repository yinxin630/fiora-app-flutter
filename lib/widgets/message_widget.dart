import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  final String content;

  MessageWidget({this.content});

  @override
  Widget build(BuildContext context) {
    return 
    Text(
      content
    );
  }
}