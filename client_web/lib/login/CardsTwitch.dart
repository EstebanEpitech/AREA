import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:auth0_flutter_web/auth0_flutter_web.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;

Auth0 auth0;

class CardTemplateTwitch extends StatefulWidget {
  final String title;
  final String description;
  final String altDescription;
  final String altExemple;
  final String secondDescription;
  final String imagePath;

  const CardTemplateTwitch(
      {Key key,
      this.title,
      this.description,
      this.altDescription,
      this.altExemple,
      this.secondDescription,
      this.imagePath,
      i})
      : super(key: key);
  @override
  _CardTemplateState createState() => _CardTemplateState();
}

class _CardTemplateState extends State<CardTemplateTwitch> {
  String clientId = "y4a4qd9zsxg8pa2mzudaoomnjwv8iw";
  void auth0f() async {}
  String _token;
  html.WindowBase _popupWin;

  bool _visible = false;

  void _toggle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _visible = !_visible;
    });
    prefs.setBool('visibilityTwitch', _visible);
  }

  Future<String> _validateToken() async {
    final response = await http.get(
      Uri.parse('https://id.twitch.tv/oauth2/validate'),
      headers: {'Authorization': 'OAuth $_token'},
    );
    return (jsonDecode(response.body) as Map<String, dynamic>)['user_id']
        .toString();
  }

  Future<http.Response> createPostServiceIn(
      String userId, String serviceName, final serviceData) {
    //userId
    // serviceName: ‘twitch’
    // serviceData: json
    final json = {
      "userId": userId,
      "serviceName": serviceName,
      "serviceData": serviceData
    };
    return http.post(
      "http://localhost:8080/api/firebase/update/updateServices",
      body: json,
    );
  }

  void _login(String data) async {
    /// Parse data to extract the token.
    final receivedUri = Uri.parse(data);

    /// Close the popup window
    if (_popupWin != null) {
      _popupWin.close();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // _token = receivedUri.fragment
      //     .split('&')
      //     .firstWhere((e) => e.startsWith('code='))
      //     .substring('code='.length);
      const start = "http://localhost:8081/static.html?code=";
      const end = "&scope=channel";

      final startIndex = data.indexOf(start);
      final endIndex = data.indexOf(end, startIndex + start.length);
      String code = data.substring(startIndex + start.length, endIndex);
      dynamic _userData, _twitchData, _verifData;
      // make GET request
      String url =
          'http://localhost:8080/api/twitch/callback?code=$code&scope=channel%3Aread%3Asubscriptions+user%3Aread%3Aemail&state=jcmlwr9mq7zgk1x9ip8ukk73ffikka';
      await http
          .get(url)
          .then((response) => _userData = jsonDecode(response.body));
      // sample info available in response
      // int statusCode = response.statusCode;
      // Map<String, String> headers = response.headers;
      // String contentType = headers['content-type'];

      final json = {
        "access_token": _userData['access_token'],
        "expires_in": _userData['expires_in'],
        "token_type": _userData['token_type']
      };

      Map map = {
        'userId': prefs.getString('userId'),
        'serviceName': 'twitch',
        'serviceData': {
          'access_token': _userData['access_token'],
          'expires_in': _userData['expires_in'],
          'token_type': _userData['token_type']
        },
      };
      _token = _userData['access_token'];
      final dataTwtich = {
        'userId': prefs.getString('userId'),
        'serviceName': 'twitch',
        'serviceData': {
          'access_token': _userData['access_token'],
          'expires_in': _userData['expires_in'],
          'token_type': _userData['token_type'],
          'userid': await _validateToken()
        }
      }; //verif ici

      final dataSendToken = {
        'access_token': _userData['access_token'],
        'userDataId': prefs.getString('userId')
      };

      try {
        http.Response responsa = await http.post(
          "https://customeyes.loca.lt/api/verif/twitchid",
          body: dataSendToken,
        );
        if (this.mounted) {
          setState(() {
            _verifData = responsa.body;
          });
        }
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Failed to sign in with Twitch: ${e} "),
            content: Text('Close this window'),
          ),
        );
      }
      // if ()

      //Here we loop through the elements of the list
      //This is how you get a value from a Map.
      // int id = _verifData["status"];
      Map<String, dynamic> map2 = jsonDecode(_verifData);

      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     title: Text("Failed to sign in with Twitch: ${_verifData}"),
      //     content: Text('Close this window'),
      //   ),
      // );
      if (map2['status'] == 200) {
        try {
          http.Response respons = await http.post(
            "http://localhost:8080/api/firebase/update/updateServices",
            body: jsonEncode(dataTwtich),
            headers: {"Content-Type": "application/json"},
            encoding: Encoding.getByName("utf-8"),
          );
          _twitchData = respons.body;
          prefs.setString("userIDTwitch", await _validateToken());
          prefs.setString("userIDToken", _token);
          showTopSnackBar(
            context,
            CustomSnackBar.info(
              icon:
                  Icon(Icons.info_rounded, color: Color(352321356), size: 120),
              message:
                  "Service Twitch ajouté pour l'utilisateur ${prefs.getString('userId')} status : ",
            ),
          );
          prefs.setBool('visibilityTwitch', false);
        } catch (e) {
          print(e);
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Failed to sign in with Twitch: ${e}"),
              content: Text('Close this window'),
            ),
          );
        }
      } else {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            icon: Icon(Icons.fire_extinguisher_rounded,
                color: Color(352321356), size: 120),
            message:
                "Service Twitch non ajouté pour l'utilisateur ${prefs.getString('userId')} status : ",
          ),
        );
        _toggle();
      }
      _popupWin = null;
    }
  }

  @override
  void initState() {
    super.initState();
    auth0f();
    // animationController = new AnimationController(
    //     vsync: this, duration: new Duration(seconds: 1));
    // animation =
    //     new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    // animation.addListener(() => this.setState(() {}));
    // animationController.forward();

    // setState(() {
    //   _visible = !_visible;
    // });
    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.all(20.0),
      // color: Colors.blue,
      child: new InkWell(
        borderRadius: BorderRadius.circular(20),
        hoverColor: Colors.purple[900],
        onTap: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.title),
                    CloseButton(
                      color: Color(0xFFD5D3D3),
                      onPressed: () async {
                        // Map<String, dynamic> user = await auth0.getUser();
                        showTopSnackBar(
                          context,
                          CustomSnackBar.info(
                            icon: Icon(Icons.info_rounded,
                                color: Color(352321356), size: 120),
                            message:
                                "Pour ajouter un service, il faut cliquer sur le bouton obtenir.",
                          ),
                        );
// 'Client-ID': 'k3vfi56fwu9yj360n3qu13t776586h'
// 'client_id': 'k3vfi56fwu9yj360n3qu13t776586h',
//     'client_secret': 'jcmlwr9mq7zgk1x9ip8ukk73ffikka',
//     'grant_type': 'authorization_code',
//     'code': reqcode,
//     'redirect_uri': 'http://localhost:8080/api/twitch/callback',
// pour l'access token je te laisse en avoir un, tu peux aussi générer un app token avec la doc
// (jte laisse en avoir un car le mien doit plus etre bon)
                        // await auth0.loginWithPopup();
                        // Map<String, dynamic> user = await auth0.getUser();
                        // setState(() {
                        //   _loggedIn = true;
                        //   _name = user["name"];
                        //   _avatarUrl = user["picture"];
                        // });
                        Navigator.of(context).pop();
                        //nouvelle fonction qui ouvre une nouvelle pop-up
                      },
                    ),
                  ],
                ),
                content: new Container(
                  width: 260.0,
                  child: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        //Image.asset("assets/app/gmail.png"),
                        Text(widget.description),
                        Text(widget.altDescription),
                        Text(widget.altExemple),
                        Text(widget.secondDescription),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Obtenir'),
                    onPressed: () async {
                      /// Listen to message send with `postMessage`.
                      html.window.onMessage.listen(
                        (event) {
                          /// The event contains the token which means the user is connected.
                          if (event.data.toString().contains('code=')) {
                            _login(event.data);
                          }
                        },
                      );

                      /// You are not connected so open the Twitch authentication page.
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final currentUri = Uri.base;
                        final redirectUri = Uri(
                          host: currentUri.host,
                          scheme: currentUri.scheme,
                          port: currentUri.port,
                          path: '/static.html',
                        );
                        final authUrl =
                            'https://id.twitch.tv/oauth2/authorize?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=channel:read:subscriptions%20user:read:email&state=jcmlwr9mq7zgk1x9ip8ukk73ffikka';
                        _popupWin = html.window.open(authUrl, "Twitch Auth",
                            "width=800, height=900, scrollbars=yes");
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          // width: 100.0,
          // height: 50.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(widget.imagePath),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
