import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client_web/main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<String> signOut(BuildContext context) async {
  await _auth.signOut();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  prefs.setBool('auth', false);

  Navigator.pushNamed(
    context,
    '/signout',
  );
  // uid = null;
  // userEmail = null;

  return 'User signed out';
}
