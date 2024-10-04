import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  final String text;
  final double padding;
  const PaddedText({super.key, required this.text, this.padding = 8.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      color: Colors.red,
      child: Text(text),
    );
  }
}
