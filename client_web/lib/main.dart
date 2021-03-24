import 'package:flutter/material.dart';
import 'package:client_web/intro.dart';
import 'package:client_web/login/SignIn.dart';
import 'package:client_web/login/SignUp.dart';
import 'package:client_web/colorhex.dart';
import 'package:client_web/area.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//AuthService appAuth = new AuthService();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var username;
  bool authSignedIn;
  SharedPreferences prefs;
  prefs = await SharedPreferences.getInstance().then((prefs) {
    //calling setState will refresh your build method.
    username = prefs.getString('userName') ?? "Bienvenue Nouvel utilisateur";
    // authSignedIn = prefs.getBool('auth') ?? false;
  });
  // Set default home.
  Widget _defaultHome = new Intro();

  // Get result of the login function.
  /*bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = new HomePage();
  }*/

  // Run app!
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Stana',
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: _defaultHome,
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData(brightness: Brightness.dark),
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new LoadingPage(title: username),
      '/signout': (BuildContext context) => new Intro(),
      '/signin': (BuildContext context) => new SignIn(),
      '/signup': (context) => SignUp(title: 'Stana SignUp'),
      '/area' : (BuildContext context) => new Area()
    },
  ));
}

class LoadingPage extends StatefulWidget {
  LoadingPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _FirstPage createState() => _FirstPage();
}

class _FirstPage extends State<LoadingPage> {
  callAPI() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    bool authSignedIn = prefs.getBool('auth') ?? false;

    Timer(Duration(seconds: 5), () {
      authSignedIn == false
          ? Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => SignIn()))
          : Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext ctx) => SignIn()));
    });
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  timerI() {
    Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    Widget logoNahele() {
      Size size = MediaQuery.of(context).size;
      return Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.07),
            InkWell(
              splashColor: Colors.transparent,
              child: Image.asset(
                "assets/stana_logo.png",
                height: size.height * 0.30,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: size.height * 0.07),
            Text(
              widget.title +
                  ', patientez d\'être officiellement redirigé par le service concerné.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white60,
              ),
            ),
            SizedBox(height: size.height * 0.07),
            Text(
              'Si ce n\'est pas le cas, patientez quelques instants.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: size.height * 0.07),
            CircularProgressIndicator(
              backgroundColor: '#CCDADA'.toColor(),
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              strokeWidth: 3,
            ),
          ]);
    }

    return Material(
        child: Container(
            color: '#001F3D'.toColor(),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                logoNahele(),
              ],
            ))));
    // }
  }
}
