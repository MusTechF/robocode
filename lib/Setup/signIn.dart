import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:robocode/Pages/home.dart';
import 'package:robocode/Setup/signUp.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Sign in'),
      ),*/
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.9, 0.1), // 10% of the width, so there are ten blinds.
                colors: [
                  Colors.lightGreen,
                  Colors.lightGreenAccent,
                  //Colors.blueGrey,
                  const Color(0xFFFFFFEE),
                  const Color(0xFF999999)
                ], // whitish to gray
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "./assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'please type an email';
                            } else if (!input.contains('@')) {
                              return 'please provide a valid email';
                            }
                          },
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(height: 25.0),
                        TextFormField(
                          obscureText: true,
                          validator: (input) {
                            if (input.isEmpty) {
                              return 'please type a password';
                            } else if (input.length < 6) {
                              return 'your password should be at least 6 characters';
                            }
                          },
                          onSaved: (input) => _password = input,
                          decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.lock,
                              ),
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(height: 45.0),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.lightGreen, //Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            splashColor: Colors.greenAccent,
                            onPressed: signIn,
                            child: Text("Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.lightBlue, //Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            splashColor: Colors.blueAccent,
                            onPressed: navigateToSignUp,
                            child: Text("Create account",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: _email, password: _password))
            .user;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home(user: user)));
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // Retrieve the text the user has entered by using the
              // TextEditingController.
              content: Text("Hello P-SET 1 is to get into the maze until you reach the green spot"),
            );
          },
        );
      } catch (e) {
        print(e.message);
      }
    }
  }
  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(),fullscreenDialog: true));
  }
}
