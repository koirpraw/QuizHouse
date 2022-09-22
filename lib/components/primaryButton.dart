import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({Key? key, required this.title,required this.buttonWidth,required this.backgroundColor,required this.onPressed,required this.textColor, buttonHight}) : super(key: key) ;

 late String title;
 late Color backgroundColor;
 late double buttonWidth;
  late double buttonHight;
 final GestureTapCallback onPressed;
 late Color textColor;


  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 40,
        width: buttonWidth,
        child: Center(child: Text(title,style: TextStyle(color: textColor,fontSize: 20))),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor
        ),

      ),
    );
  }
}
