import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../login/login.dart';
import '../hook.dart';

class LandingPage extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;



                if (user == null) {
                  return HomePage();
                } else {
                  return HookPage();
                }


              }
              return Scaffold(
                body: Center(
                  child: Text("Cheking Authentication..."),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Connecting to the app"),
          ),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ColoredBox(
        color: Color.fromRGBO(51, 51, 76, 1),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Image(
                    image: AssetImage('assets/stana_logo.png'),
                    width: 250.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            Text(
              'Bienvenue sur Stana.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.07),
            Text(
              'Votre nouvel assistant organisationnel !',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  height: 42.0,
                  width: 100.0,
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(71, 71, 91, 1),
                      borderRadius: BorderRadius.all(Radius.circular(35.0)),
                    ),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignIn()),
                        );
                      },
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(">",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15
                                    )
                                ),
                              ],
                            ),
                          ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding:
                              const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),
                            Divider(
                              color: Colors.white,
                              height: 20,
                              thickness: 1.5,
                              indent: 75,
                              endIndent: 75,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.copyright_sharp,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                    Text(
                                      " Copyright - Stana 2021",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
