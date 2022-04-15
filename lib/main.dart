import 'package:flutter/material.dart';

import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/login.dart';
import 'package:uva_media/screens/DashBoard.dart';
import 'package:uva_media/screens/make_post.dart';
import 'package:uva_media/screens/pretty_login.dart';

// import 'package:flutter_session/flutter_session.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';

import 'Screens/feed.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // added 4/14
  dynamic token = FlutterSession().get('token');
  runApp(MaterialApp(routes: {
    '/': (context) =>
        (token != '' ? LoginScreen2() : MyCustomForm()), //MyApp(), // DashBoard
    '/login': (context) => LoginScreen2(), // LoginScreen(),
    '/post': (context) => MyCustomForm(), // PostPage
  }));
}
