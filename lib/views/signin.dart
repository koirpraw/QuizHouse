import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizhouse/utils/constants.dart';
import 'package:quizhouse/views/altHome.dart';
import 'package:quizhouse/views/homepage.dart';
import 'package:quizhouse/views/signup.dart';
import 'package:quizhouse/widgets/applogo.dart';

import '../services/auth.dart';
import '../services/remote_db.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  String email = '', password = '',name='';
  bool _isLoading = true;

  late final emailTextController = TextEditingController();
  late final passwordTextController = TextEditingController();

  userSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService.signInEmailAndPass(email, password).then((value) {
        if (value != null){
          setState(() {
            _isLoading =false;
          });
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        }
      } );


        // HelperConstants.saveUserLoggedInSharedPreference(true);



    }
  }

  signUserIn() async {
    await authService.signInEmailAndPass(email, password);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        centerTitle: Platform.isAndroid ? true : null,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Spacer(),
              Container(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Enter Email'),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailTextController,

                      onChanged: (val) => email = val,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Enter Password'),
                      controller: passwordTextController,
                      validator: (val) => val!.length < 6
                          ? "Password must be 6+ characters"
                          : null,
                      onChanged: (val) => password = val,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUserIn();
                        // signUserIn();

                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.lightGreen),
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not Signed up yet?'),
                        SizedBox(
                          width: 6,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            child: Text(
                              'SIGN UP',
                              style: kLinkText,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
