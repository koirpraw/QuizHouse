import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quizhouse/services/auth.dart';
import 'package:quizhouse/widgets/applogo.dart';

class AltHomePage extends StatelessWidget {
  AltHomePage({Key? key}) : super(key: key);

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
        centerTitle: Platform.isAndroid ? true : null,
        actions: [
          IconButton(
              onPressed: () {
                authService.signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}
