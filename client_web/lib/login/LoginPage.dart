import 'package:flutter/material.dart';
import 'package:client_web/colorhex.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(51, 51, 76, 1),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.20),
            Image.asset(
              "assets/stana_logo.png",
              height: size.height * 0.40,
            ),
            SizedBox(height: size.height * 0.05),
            // SizedBox(height: size.height * 0.05),
            SizedBox(
              width: 240,
              height: 40,
              child: FlatButton(
                color: '#CCDADA'.toColor(),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.grey,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/signin',
                  );
                },
                child: Text(
                  "Se connecter",
                  style: TextStyle(
                    fontSize: 27.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: 240,
              height: 40,
              child: FlatButton(
                color: '#CCDADA'.toColor(),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.grey,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/signup',
                  );
                },
                child: Text(
                  "S'inscrire",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Colors.blue, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(height: size.height * 0.15),

            // SizedBox(height: size.height * 0.50),
          ],
        ),
      ),
    );
  }
}
