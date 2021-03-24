import 'package:comon/login/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/Start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../hook.dart';

class SignIn extends StatelessWidget {
  double _height;
  double _width;
  String _pseudo;
  String _email;
  String _password;
  String _verif;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Material(
        child: Container(
            color: Color.fromRGBO(51, 51, 76, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 70, 40, 16),
                  child: Column(

                    children: <Widget>[
                      //formSignIn(context),
                      SizedBox(height: size.height * 0.06),
                      RaisedButton(
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
                      SizedBox(height: size.height * 0.02),
                      RaisedButton(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HookPage()),
                            );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Connexion()),
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
                )
              )
          )
        )
    );
  }
}

class Connexion extends StatelessWidget {

  double _height;
  double _width;
  String _pseudo;
  String _email;
  String _password;
  String _verif;
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return Material(
        child: Container(
            color: Color.fromRGBO(51, 51, 76, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 100, 50, 16),
                    child: Column(

                      children: <Widget>[
                        //formSignIn(context),
                        SizedBox(height: size.height * 0.06),
                        RaisedButton(
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
                        SizedBox(height: size.height * 0.02),
                        RaisedButton(
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
                            obscureText: true,
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
                        SizedBox(height: size.height * 0.04),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HookPage()),
                              );
                            },
                            child: Text(
                              ">",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.08),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()),
                            );
                          },
                          child: Text(
                            "Vous n'avez pas encore de comtpe ? S'inscrire",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
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
                    )
                )
            )
        )
    );
  }
}