import 'package:flutter/material.dart';

import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/login.dart';
import 'package:uva_media/screens/DashBoard.dart';
import 'package:uva_media/screens/make_post.dart';

import 'package:flutter_session/flutter_session.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // added 4/14
  dynamic token = FlutterSession().get('token');
  runApp(MaterialApp(routes: {
    '/': (context) => (token != '' ? LoginScreen() : DashBoard()), //MyApp(),
    '/login': (context) => LoginScreen(), // LoginScreen(),
    '/post': (context) => MyCustomForm(), // PostPage
  }));
}
