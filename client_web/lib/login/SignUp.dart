import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:client_web/colorhex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:core';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  SignUp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySignUpState createState() => _MySignUpState();
}

class _MySignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  bool _success;
  String _userEmail;
  double _height;
  double _width;
  String _pseudo;
  String _email;
  String _password;
  String _verif;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Material(
        child: Container(
            color: Color.fromRGBO(51, 51, 76, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //     gradient: new LinearGradient(
            //   end: const Alignment(0.0, -1),
            //   begin: const Alignment(0.0, 0.6),
            //   colors: ['#514a9d'.toColor(), '#24c6dc'.toColor()],
            // )),
            child: SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 3, 200, MediaQuery.of(context).size.width / 3, 16),
                child: Column(
              children: <Widget>[
                //formSignIn(context),
                SizedBox(height: size.height * 0.06),
                Padding(
                  padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: RaisedButton(
                  onPressed: () {},
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/apple.png'),
                        Text(
                          'Se connecter avec Apple',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ),
                SizedBox(height: size.height * 0.02),
                Padding(
                  padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: RaisedButton(
                  onPressed: () {},
                  color: Color.fromRGBO(33, 45, 80, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset('assets/facebook.png'),
                        Text(
                          'Se connecter avec Facebook',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ),

                SizedBox(height: size.height * 0.04),
                Text(
                  '_____________________________________________________',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Container(
                  height: size.height * 0.07,
                  child: TextField(
                    onChanged: (value) {
                      _pseudo = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(95, 95, 115, 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,//this has no effect
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        hintText: "NOM UTILISATEUR",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        )
                    ),

                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.07,
                  child: TextField(
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(95, 95, 115, 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,//this has no effect
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        hintText: "EMAIL OU NUMERO DE TEL.",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.07,
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      _password = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(95, 95, 115, 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,//this has no effect
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        hintText: "MOT DE PASSE",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  height: size.height * 0.07,
                  child: TextField(
                    obscureText: true,
                    onChanged: (value) {
                      _verif = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(95, 95, 115, 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,//this has no effect
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        hintText: "VERIFIER MOT DE PASSE",
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Container(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    color: Color.fromRGBO(27,30, 52, 1),
                    shape: RoundedRectangleBorder(side: BorderSide(
                        color: Color.fromRGBO(27,30, 52, 1),
                        width: 1,
                        style: BorderStyle.solid
                    ), borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                    },
                    child: Text(
                      ">",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/signin',
                    );
                  },
                  child: Text(
                    "J'ai déjà un compte ? Oui !",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Text(
                  'By clicking on next, you acknowledge that you have read '
                      'and accepted the Terms of Service and the '
                      'Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
              ],
            )))));
  }

  Widget logoNahele() {
    Size size = MediaQuery.of(context).size;
    return Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.07),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/',
              );
            },
            child: Image.asset(
              "assets/stana_logo.png",
              height: size.height * 0.30,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: size.height * 0.07),
        ]);
  }

  Widget formSignIn() {
    Size size = MediaQuery.of(context).size;

    return Container(
        //margin: EdgeInsets.only(left: _width / 2.5),
        child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    width: 280,
                    height: 40,
                    child: TextFormField(
                      controller: _usernameController,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50),
                          ),
                        ),
                        hintText: 'Username',
                        hintStyle: new TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(
                    width: 280,
                    height: 40,
                    child: TextFormField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      autofocus: false,
                      validator: (value) {
                        Pattern pattern =
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                            r"{0,253}[a-zA-Z0-9])?)*$";
                        RegExp regex = new RegExp(pattern);
                        if (_emailController.text != null) {
                          if (value.isEmpty) {
                            return 'Email can\'t be empty';
                          } else if (!regex.hasMatch(value)) {
                            return 'Enter a correct email address';
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      backgroundColor: Colors.redAccent,
                                      title: Text(
                                          "Please enter a valid email : ${value} is not valid."),
                                      content: Text('Try again.'),
                                    ));
                          }
                        }
                      },
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50),
                          ),
                        ),
                        hintText: 'Email',
                        hintStyle: new TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  SizedBox(
                    width: 280,
                    height: 40,
                    child: TextFormField(
                      controller: _passwordController,
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (_passwordController.text != null) {
                          if (value.isEmpty) {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      backgroundColor: Colors.redAccent,
                                      title: Text(
                                          "Please enter a valid password, the pass is not valid."),
                                      content: Text('Try again.'),
                                    ));
                            return 'Password can\'t be empty';
                          }
                        }
                      },
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50),
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: new TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                        filled: true,
                      ),
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget fom() {
    Size size = MediaQuery.of(context).size;
    return Container(
      //margin: EdgeInsets.only(left: _width / 2.5),
      child: Column(
        children: <Widget>[
          // SizedBox(height: size.height * 0.05),
          SizedBox(height: size.height * 0.02),
          Align(
            alignment: Alignment(0.08, 0.0),
            child: SizedBox(
              // mainAxisAlignment: MainAxisAlignment.center,
              width: 140,
              height: 40,
              child: FlatButton(
                color: '#CCDADA'.toColor(),
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.grey,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _makePostRequestSignUp();
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: 240,
            height: 40,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05, width: 1),
                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05, width: 2),
                ]),
          ),

          Wrap(
            direction: Axis.horizontal,
            spacing: 20.0,
            runSpacing: 4.0,
            children: <Widget>[
              AnimatedIconButton(
                size: 35.0,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/signin',
                  );
                },
                duration: Duration(milliseconds: 200),
                endIcon: Icon(
                  FontAwesomeIcons.signInAlt,
                  color: Colors.purple,
                ),
                startIcon: Icon(
                  FontAwesomeIcons.doorOpen,
                  color: Colors.purpleAccent,
                ),
                startBackgroundColor: '#CCDADA'.toColor(),
                endBackgroundColor: '#CCDADA'.toColor(),
                splashColor: Colors.purple,
              )
            ],
          ),
          // SizedBox(height: size.height * 0.50),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Map<String, String> toJson() {
    Map<String, String> map = {
      'email': _emailController.text.toLowerCase(),
      'password': _passwordController.text.toLowerCase(),
      'username': _usernameController.text.toLowerCase(),
    };

    return map;
  }

  // Map<String, String> headers = {
  //   'Content-type': 'application/json',
  //   'Accept': 'application/json',
  // };

  Future<http.Response> createPost(
      String email, String password, String username) {
    final json = {
      "email": email,
      "password": password,
      "username": username,
    };
    return http.post(
      "http://localhost:8080/api/firebase/auth/signUp",
      body: json,
    );
  }

  void _makePostRequestSignUp() async {
    try {
      createPost(
          _emailController.text.toLowerCase(),
          _passwordController.text.toLowerCase(),
          _usernameController.text.toLowerCase());
      await Future.delayed(Duration(seconds: 1));

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', false);
      // prefs.setString('email', "response.body");
      Navigator.pushNamed(
        context,
        '/signin',
      );
      // var options = Options(
      //     contentType: "application/json; charset=UTF-8",
      //     followRedirects: false,
      //     method: 'POST',
      //     validateStatus: (status) {
      //       return status < 500;
      //     });
      // String url = "http://localhost:8080/api/firebase/auth/signUp";
      // dio.post(
      //   url,
      //   data: jsonEncode(formData),
      //   options: options,
      //   // options: options,
      // );
      // final response = await http.post(url, body: toJson());
      // if (response.statusCode == 200 || response.statusCode == 400) {
      //   json.decode(response.body);
      // } else {
      //   showDialog(
      //       context: context,
      //       builder: (_) => AlertDialog(
      //             title: Text(
      //                 "This the text: ${response.body} and response is ${response.statusCode}"),
      //             content: Text('Close this window'),
      //           ));
      //   await Future.delayed(Duration(seconds: 1));

      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   prefs.setString('email', response.body);
      //   Navigator.pushNamed(
      //     context,
      //     '/home',
      //   );
      // }
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Failed to sign in with mail and password: ${e}"),
                content: Text('Close this window'),
              ));
    }
    throw Exception('Failed to load data!');
  }
}
