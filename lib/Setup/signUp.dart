import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:robocode/Setup/signIn.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('hey'),
      ),*/
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.9, 0.1), // 10% of the width, so there are ten blinds.
                colors: [
                  Colors.lightBlue,
                  Colors.lightBlueAccent,
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
                          color: Colors.lightBlue, //Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            splashColor: Colors.blueAccent,
                            onPressed: signUp,
                            child: Text("Create account",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.0),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.lightGreen, //Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            splashColor: Colors.greenAccent,
                            onPressed: navigateToSignIn,
                            child: Text("Login",
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

  Future<void> signUp() async {
    final formState = _formkey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        user.sendEmailVerification();
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              // Retrieve the text the user has entered by using the
              // TextEditingController.
              content: Text("Email Verification sent... please confirm your email!"),
            );
          },
        );
      } catch (e) {
        print(e.message);
      }
    }
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(),fullscreenDialog: true));
  }
}
