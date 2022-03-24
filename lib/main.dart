import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/login.dart';
// import 'package:uva_media/screens/post_options.dart';
import 'package:flutter/material.dart';
import 'package:uva_media/screens/make_post.dart';

void main() {
  runApp(MaterialApp(routes: {
    '/': (context) => LoginScreen(), //MyApp(),
    '/login': (context) => LoginScreen(), // LoginScreen(),
    '/post': (context) => MyCustomForm(), // PostPage
  }));
}
