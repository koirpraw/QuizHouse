import 'package:flutter/material.dart';
import 'package:quizhouse/views/homepage.dart';
import 'package:quizhouse/widgets/applogo.dart';

class ResultPage extends StatefulWidget {
  // const ResultPage({Key? key}) : super(key: key);
  final int total, correct, incorrect, notattempted;
  ResultPage({required this.incorrect, required this.total, required this.correct, required this.notattempted});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${widget.correct}/${widget.total}"),
              Text("You answered ${widget.correct} answers correctly and ${widget.incorrect} incorrectly"),
              SizedBox(height: 12,),
              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
              }, child: Text("Home"))
            ],
          ),
        ),
      ),
    );
  }
}
