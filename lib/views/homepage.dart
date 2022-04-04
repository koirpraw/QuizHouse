import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:quizhouse/views/create_quiz.dart';
import 'package:quizhouse/views/signin.dart';
import 'package:quizhouse/widgets/applogo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizhouse/services/remote_db.dart';
import 'package:quizhouse/services/auth.dart';

import '../widgets/quiztile.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ref = FirebaseFirestore.instance.collection("Quiz");
  Stream<QuerySnapshot<Object?>>? quizStream;

  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();

  Widget quizList() {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: quizStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.data == null
              ? Container(
                  child: Center(child: CircularProgressIndicator()),
                )
              : ListView.builder(
                  // shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      noOfQuestions: snapshot.data?.docs.length,
                      imageUrl: snapshot.data?.docs[index]['quizImgUrl'],
                      title: snapshot.data?.docs[index]['quizTitle'],
                      description: snapshot.data?.docs[index]['quizDesc'],
                      id: snapshot.data?.docs[index]["quizId"],
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });

    // TODO: implement initState
    super.initState();
  }

  signUserOut() {
    authService.signOut();
  }

  delaySignOut() async {
    await Future.delayed(Duration(seconds: 3));
    return CircularProgressIndicator(
      color: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AppLogo(),
        actions: [
          // ExitDialog()
          IconButton(onPressed: (){
            delaySignOut();
            signUserOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));
          },
              icon: Icon(Icons.exit_to_app_rounded,color: Colors.lightGreen,))
        ],
        centerTitle: Platform.isAndroid ? true : null,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(child: quizList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
        tooltip: 'create quiz',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ExitDialog extends StatelessWidget {
  ExitDialog({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  signUserOut() {
    authService.signOut();
  }

  delaySignOut() async {
    await Future.delayed(Duration(seconds: 3));
    return CircularProgressIndicator(
      color: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: const Text('Exit and Close')),
          content: const Text('Are you Sure you want to exit? '),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
                onPressed: () {
                  signUserOut();
                },
                child: const Text('Exit')),
          ],
        ),
      ),
      icon: const Icon(
        Icons.exit_to_app_rounded,
        color: Colors.grey,
      ),
    );
  }
}
