import 'package:comon/login/Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './login/Start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class HookPage extends StatefulWidget {
  @override
  _HookPageState createState() => _HookPageState();
}

class _HookPageState extends State<HookPage> {

  List <bool> listAction = [false, false, false, false, false, false];
  List <bool> listReaction = [false, false, false, false, false, false];
  List <String> service = ["Facebook", "Instagram", "Gmail", "Outlook", "Timer", "Twitter"];

 /* void postArea() async
  {
    var endPoint = "https://area.pinteed.com/user/area?token=" + global.token;

    Map data = {
      'name': ,
      'description': ,
      'activated': 1,
      'action' : {
        'action_id': ,
        'param1':
      },
      'reaction' : {
        'reaction_id': ,
        'param1': ,
        'param2': ,
      }
    };

    var body = json.encode(data);
    print(body);
    var response = await http.post(endPoint,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }*/


  void refresh()
  {
    setState(() {
    });
  }

  void checkBothSelected() async
  {
    bool action = false;
    bool reaction = false;
    int i = 0;
    int j = 0;
    print("in check");

    for (; i < 6; i++)
      if (listAction[i] == true) {
        action = true;
        break;
      }

    for (; j < 6; j++)
      if (listReaction[j] == true) {
        reaction = true;
        break;
      }

    if (action == true && reaction == true) {
      setState(() {

      });

    }
  }

  void getAction(int i) {
    setState(() {
      for (int j = 0; j < 6; j++) {
        if (j != i)
          listAction[j] = false;
        if (j == i)
          listAction[j] = !listAction[j];
      }
    });
    checkBothSelected();
  }

  void getReaction(int i) {
    setState(() {
      for (int j = 0; j < 6; j++) {
        if (j != i)
          listReaction[j] = false;
        if (j == i)
          listReaction[j] = !listReaction[j];
      }
    });
    checkBothSelected();
  }


  @override
  Widget build(BuildContext context) {
      return new Scaffold(
          body: Column(
              children: <Widget>[
                Text("Select Action", style: TextStyle(height: 1.5, fontSize: 20,fontWeight: FontWeight.bold),),
                Expanded(
                    child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getAction(0);}  ,
                                  color: listAction[0] == false ? Colors.white70 : Colors.blue,
                                  splashColor: Colors.cyanAccent,
                                  child: new Image.asset('assets/facebook_logo.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getAction(1);}  ,
                                  color: listAction[1] == false? Colors.white70 : Colors.blue,
                                  splashColor: Colors.cyanAccent,
                                  child: new Image.asset('assets/instagram.png'))),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getAction(2);}  ,
                                  color: listAction[2]  == false? Colors.white70 : Colors.blue,
                                  splashColor: Colors.cyanAccent,
                                  child: new Image.asset('assets/gmail.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getAction(3);}  ,
                                  color: listAction[3]  == false? Colors.white70 : Colors.blue,
                                  splashColor: Colors.cyanAccent,
                                  child: new Image.asset('assets/outlook.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getAction(4);}  ,
                                  color: listAction[4]  == false? Colors.white70 : Colors.blue,
                                  child: new Image.asset('assets/timer.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getAction(5);}  ,
                                  color: listAction[5] == false ? Colors.white70 : Colors.blue,
                                  child: new Image.asset('assets/twitter.png'))
                          ),
                        ])),
                Text("Select Reaction", style: TextStyle(height: 1.5, fontSize: 20,fontWeight: FontWeight.bold),),
                Expanded(
                    child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getReaction(0);}  ,
                                  color: listReaction[0] == false ? Colors.white70 : Colors.blue,
                                  child: new Image.asset('assets/facebook_logo.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getReaction(1);}  ,
                                  color: listReaction[1] == false ? Colors.white70 : Colors.blue,
                                  child: new Image.asset(
                                      'assets/instagram.png'))),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getReaction(2);}  ,
                                  color: listReaction[2] == false ? Colors.white70 : Colors.blue,
                                  child: new Image.asset('assets/gmail.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getReaction(3);}  ,
                                  color: listReaction[3] == false ? Colors.white70 : Colors.blue,
                                  child: new Image.asset('assets/outlook.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getReaction(4);}  ,
                                  color: listReaction[4] == false ? Colors.white70 : Colors.blue,
                                  child: new Image.asset('assets/timer.png'))
                          ),
                          Container(
                              padding: const EdgeInsets.all(8),
                              child: new RaisedButton(
                                  onPressed: () { getReaction(5);}  ,
                                  color: listReaction[5] == false ? Colors.white70 : Colors.blue,
                                  child: new Image.asset('assets/twitter.png'))
                          ),
                        ]))
              ]
          )
      );
  }
}