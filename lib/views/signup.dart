import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizhouse/components/primaryButton.dart';
import 'package:quizhouse/services/auth.dart';
import 'package:quizhouse/services/remote_db.dart';
import 'package:quizhouse/utils/constants.dart';
import 'package:quizhouse/views/altHome.dart';
import 'package:quizhouse/views/homepage.dart';
import 'package:quizhouse/views/signin.dart';
import '../widgets/applogo.dart';
import 'package:quizhouse/utils/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  AuthService authService = AuthService();
  DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  String name = '', email = '', password = '';

  late final passwordTextController = TextEditingController();
  late final emailTextController = TextEditingController();
  late final nameTextController = TextEditingController();

  getInfoAndSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        databaseService.addData(userInfo);

        HelperConstants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: AppLogo(),
        centerTitle: Platform.isAndroid? true : false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _isLoading
              ? Container(
                  child: CircularProgressIndicator(
                    color: Colors.lightGreen,
                  ),
                )
              : Column(
                  children: [
                    Spacer(),
                    Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameTextController,
                              validator: (val) {},
                              onChanged: (val) => name = val,
                              decoration:
                                  InputDecoration(hintText: 'Full Name'),
                              keyboardType: TextInputType.name,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              controller: emailTextController,
                              validator: (val) => validateEmail(email),
                              onChanged: (val) => email = val,
                              decoration:
                                  InputDecoration(hintText: 'Enter Email'),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              controller: passwordTextController,
                              obscureText: true,
                              validator: (val) => val!.length < 6
                                  ? "Password must be 6+ characters"
                                  : null,
                              onChanged: (val) {
                                password = val;
                              },
                              decoration:
                                  InputDecoration(hintText: 'Enter Password'),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            //Button SignUp
                            PrimaryButton(
                              title: 'Sign Up',


                              buttonWidth:
                                  MediaQuery.of(context).size.width / 2,
                              backgroundColor: Colors.lightGreen,
                              textColor: Colors.white,
                              onPressed: () {
                                getInfoAndSignUp();
                              },
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     getInfoAndSignUp();
                            //   },
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 24, vertical: 20),
                            //     width: MediaQuery.of(context).size.width / 2,
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(16),
                            //         color: Colors.lightGreen),
                            //     child: Text(
                            //       'Sign Up',
                            //       style: TextStyle(color: Colors.white),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Already Signed Up?'),
                                SizedBox(
                                  width: 6,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignInPage()));
                                    },
                                    child: Text(
                                      'Log In',
                                      style: kLinkText,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}
