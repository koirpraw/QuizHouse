import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({required this.title,}) ;

 late String title;
 late Color backgroundColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width/2,
    );
  }
}
