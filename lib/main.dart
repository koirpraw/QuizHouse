import 'package:flutter/material.dart';
import 'package:quizhouse/utils/constants.dart';
import 'package:quizhouse/views/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizhouse/views/signin.dart';
import 'package:quizhouse/views/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async {
    _isLoggedIn =
        (await HelperConstants.getUerLoggedInSharedPreference().then((value) {
      setState(() {
        _isLoggedIn = value!;
      });
      return null;
    }))!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'quizHouse',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity
          // primarySwatch: Colors.lightGreen,
          ),
      home: _isLoggedIn ? MyHomePage() : SignInPage(),
    );
  }
}
