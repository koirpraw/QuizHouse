import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(style: TextStyle(fontSize: 24), children: [
      TextSpan(
          text: 'Quiz',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Colors.lightGreen)),
      TextSpan(
          text: 'House',
          style: TextStyle(
              fontWeight: FontWeight.w800, color: Colors.grey.shade700))
    ]));
  }
}
