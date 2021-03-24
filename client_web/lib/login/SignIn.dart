import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:client_web/colorhex.dart';
import 'package:client_web/login/SignUp.dart';
import 'package:client_web/login/GoogleSign.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:web_browser/web_browser.dart';
import 'dart:convert' as JSON;
import 'dart:html' as html;
import 'dart:io';
import 'dart:core';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:client_web/area.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
bool authSignedIn;
String uid;
String userEmail;
dynamic _userData, _userFollowers, _userFollowing, _userRepo;

class SignIn extends StatefulWidget {
  SignIn({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MySignInState createState() => _MySignInState();
}

class _MySignInState extends State<SignIn> {
  final TextEditingController _tokenController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;
  double _height;
  double _width;
  String _pseudo;
  String _email;
  String _password;
  String _verif;

  final String twitch_secret = '5a96io85ri2nrux4n8ix24hcynpbew';
  final String twitch_id = 'y4a4qd9zsxg8pa2mzudaoomnjwv8iw';
  String _token;

  void _loginToTwitch() {

    final currentUrl = Uri.base;
    if (!currentUrl.fragment.contains('access_token=')) {
      // You are not connected so redirect to the Twitch authentication page.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        html.window.location.assign(
          'https://id.twitch.tv/oauth2/authorize?response_type=token&client_id=$twitch_id&redirect_uri=${currentUrl.origin}&scope=viewing_activity_read',
        );
      });
    } else {
      // You are connected, you can grab the code from the url.
      final fragments = currentUrl.fragment.split('&');
      _token = fragments
          .firstWhere((e) => e.startsWith('access_token='))
          .substring('access_token='.length);
    }
  }



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
                      onPressed: () {
                        _loginToTwitch();
                      },
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
                        Navigator.pushNamed(
                          context,
                          '/area',
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
                      Navigator.pushNamed(
                        context,
                        '/signup',
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
            )))));
  }

  Widget openWeb() {
    String src = 'https://flutter.dev';

    return WebBrowser(
      initialUrl:
          'https://accounts.google.com/o/oauth2/v2/auth?access_type=offline&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fgmail.readonly%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.profile%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email%20https%3A%2F%2Fmail.google.com%2F%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fgmail.modify%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fgmail.compose%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fgmail.send%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.readonly%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.events%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.settings.readonly%20https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcalendar.addons.execute&response_type=code&client_id=308108435500-l2f4etc5u0s2h5t2sfdkn14nk36f37r6.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2Fapi%2Fgoogle%2FredirectUrlGoogle',
      javascriptEnabled: true,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    setState(() {
      _userData = null;
    });
    super.dispose();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': _emailController.text.toLowerCase(),
      'password': _passwordController.text.toLowerCase(),
    };

    return map;
  }

  Map<String, dynamic> loginToJson(String email, String name, String token) {
    Map<String, dynamic> map = {
      'email': email,
      'username': name,
      'access_token': token,
    };

    return map;
  }

  Future<http.Response> createPostIn(String email, String password) {
    final json = {
      "email": email,
      "password": password,
    };
    return http.post(
      "http://localhost:8080/api/firebase/auth/login",
      body: json,
    );
  }

  Future<http.Response> fetchAlbum() async {
    var response = await createPostIn(_emailController.text.toLowerCase(),
        _passwordController.text.toLowerCase());

    return response;
  }

  Future<http.Response> createPostGIn(
      String email, String username, String accessToken) {
    final json = {
      "email": email,
      "username": username,
      "serviceName": "Google",
      "accessToken": accessToken
    };
    return http.post(
      "http://localhost:8080/api/google/addLogin",
      body: json,
    );
  }

  Future<http.Response> createPostGiIn(
      String email, String username, String accessToken) {
    final json = {
      "email": email,
      "username": username,
      "serviceName": "Twitter",
      "accessToken": accessToken
    };
    return http.post(
      "http://localhost:8080/api/google/addLogin",
      body: json,
    );
  }

  void _makePostRequestSignIn() async {
    try {
      await createPostIn(_emailController.text.toLowerCase(),
              _passwordController.text.toLowerCase())
          .then((response) {
        // print("Response status: ${response.statusCode}");
        // print("Response body: ${response.body}");
        setState(() {
          _userData = JSON.jsonDecode(response.body);
          // _userFollowers = jsonDecode(followersResponse.body);
          // _userFollowing = jsonDecode(followingResponse.body);
          // _userRepo = jsonDecode(userRepoResponse.body);
          // _isSearching = false;
        });
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // var email = _userData['email'];
      prefs.setString('email', _userData['email']);
      prefs.setString('userName', _userData['username']);
      prefs.setString('calendarAccess', _userData['calendar']['access_token']);
      prefs.setBool('calendarUsed', _userData['calendar']['isUsed']);
      prefs.setString('twitchAccess', _userData['twitch']['access_token']);
      prefs.setBool('twitchUsed', _userData['twitch']['isUsed']);
      prefs.setString('gmailAccess', _userData['gmail']['access_token']);
      prefs.setBool('gmailUsed', _userData['gmail']['isUsed']);
      prefs.setString('userId', _userData['userId']);
      prefs.setString('combos', _userData['combos']);
      await Future.delayed(Duration(seconds: 1));

      // prefs.setString('email', _userData['email']);
      prefs.setBool('auth', true);
      // prefs.setBool('auth', true);
      // prefs.setString('googleDisplayName', user.displayName);
      Navigator.pushNamed(
        context,
        '/home',
      );
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Failed to sign in with mail and password: ${e}"),
                content: Text('Close this window'),
              ));
    }
  }

  void _signInWithGithub() async {
    try {
      UserCredential userCredential;
      TwitterAuthProvider twitterProvider = TwitterAuthProvider();

      // Once signed in, return the UserCredential
      userCredential = await _auth.signInWithPopup(twitterProvider);

      final user = userCredential.user;

      await createPostGiIn(user.email, user.displayName, "").then((response) {
        setState(() {
          _userData = JSON.jsonDecode(response.body);
        });
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      prefs.setString('email', _userData['email']);
      prefs.setString('userName', _userData['username']);
      prefs.setString('calendarAccess', _userData['calendar']['access_token']);
      prefs.setBool('calendarUsed', _userData['calendar']['isUsed']);
      prefs.setString('twitchAccess', _userData['twitch']['access_token']);
      prefs.setBool('twitchUsed', _userData['twitch']['isUsed']);
      prefs.setString('gmailAccess', _userData['gmail']['access_token']);
      prefs.setBool('gmailUsed', _userData['gmail']['isUsed']);
      prefs.setString('userId', _userData['userId']);
      prefs.setString('combos', _userData['combos']);
      // prefs.setString('email', user.uid);
      prefs.setBool('auth', true);

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (BuildContext ctx) => Home()));
      Navigator.pushNamed(
        context,
        '/home',
      );
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Failed to sign in with Twitter: ${e}"),
                content: Text('Close this window'),
              ));
    }
  }

  void _signInWithGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'https://www.googleapis.com/auth/gmail.readonly',
        "https://www.googleapis.com/auth/userinfo.profile",
        'https://www.googleapis.com/auth/userinfo.email',
        "https://mail.google.com/",
        "https://www.googleapis.com/auth/gmail.modify",
        "https://www.googleapis.com/auth/gmail.compose",
        "https://www.googleapis.com/auth/gmail.send",
        "https://www.googleapis.com/auth/calendar",
        'https://www.googleapis.com/auth/calendar.readonly',
        'https://www.googleapis.com/auth/calendar.events',
        'https://www.googleapis.com/auth/calendar.settings.readonly',
        'https://www.googleapis.com/auth/calendar.addons.execute',
      ],
    );

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    prefs.setString(
        'googleAccessToken', googleSignInAuthentication.accessToken);

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User user = userCredential.user;
    if (user != null) {
      // Checking if email and name is null
      assert(user.uid != null);
      assert(user.email != null);
      assert(user.displayName != null);

      // uid = user.uid;
      // name = user.displayName;
      // userEmail = user.email;
      String accessToken = prefs.getString('googleAccessToken');
      await createPostGIn(user.email, user.displayName, accessToken)
          .then((response) {
        // print("Response status: ${response.statusCode}");
        // print("Response body: ${response.body}");
        setState(() {
          _userData = JSON.jsonDecode(response.body);
          // _userFollowers = jsonDecode(followersResponse.body);
          // _userFollowing = jsonDecode(followingResponse.body);
          // _userRepo = jsonDecode(userRepoResponse.body);
          // _isSearching = false;
        });
        // showDialog(
        //     context: context,
        //     builder: (_) => AlertDialog(
        //           title: Text(
        //               "Failed to sign in with mail and password: ${_userData['email']}"),
        //           content: Text('Close this window'),
        //         ));
      });

      // user.getAuthToken();
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      // var email = _userData['email'];
      prefs.setString('email', _userData['email']);
      prefs.setString('userName', _userData['username']);
      prefs.setString('calendarAccess', _userData['calendar']['access_token']);
      prefs.setBool('calendarUsed', _userData['calendar']['isUsed']);
      prefs.setString('twitchAccess', _userData['twitch']['access_token']);
      prefs.setBool('twitchUsed', _userData['twitch']['isUsed']);
      prefs.setString('gmailAccess', _userData['gmail']['access_token']);
      prefs.setBool('gmailUsed', _userData['gmail']['isUsed']);
      prefs.setString('userId', _userData['userId']);
      await Future.delayed(Duration(seconds: 1));

      prefs.setBool('auth', true);
      prefs.setString('googleEmail', user.email);
      prefs.setString('googleDisplayName', user.displayName);
      await Future.delayed(Duration(seconds: 1));

      Navigator.pushNamed(
        context,
        '/home',
      );
    }
  }
}
