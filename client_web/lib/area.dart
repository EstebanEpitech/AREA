import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

const String clientId = "y4a4qd9zsxg8pa2mzudaoomnjwv8iw";

class Area extends StatefulWidget {
  @override
  _MyAreaState createState() => _MyAreaState();
}

class _MyAreaState extends State<Area> {
  bool _showUserData = false;
  String _token;
  double _height;
  double _width;

  Future<String> _validateToken() async {
    final response = await http.get(
      Uri.parse('https://id.twitch.tv/oauth2/validate'),
      headers: {'Authorization': 'OAuth $_token'},
    );
    return (jsonDecode(response.body) as Map<String, dynamic>)['login']
        .toString();
  }

  void _loginToTwitch() {
    //super.initState();

    final currentUrl = Uri.base;
    if (!currentUrl.fragment.contains('access_token=')) {
      // You are not connected so redirect to the Twitch authentication page.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        html.window.location.assign(
          'https://id.twitch.tv/oauth2/authorize?response_type=token&client_id=$clientId&redirect_uri=${currentUrl.origin}&scope=viewing_activity_read',
        );
        print(currentUrl);
      });
      print(currentUrl);
    } else {
      // You are connected, you can grab the code from the url.
      final fragments = currentUrl.fragment.split('&');
      _token = fragments
          .firstWhere((e) => e.startsWith('access_token='))
          .substring('access_token='.length);
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _showUserData = true));
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
                            onPressed: () {
                              _loginToTwitch();
                            },
                            color: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(50, 10, 30, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Se connecter avec Twitch',
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
                      ],
                    )))));
  }
}