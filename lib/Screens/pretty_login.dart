import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:uva_media/Screens/password_calculator.dart';
import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/make_post.dart';
import 'package:uva_media/screens/feed2.dart';
import 'package:uva_media/functions/functions.dart';

import 'package:mysql1/mysql1.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  _LoginScreen2 createState() => _LoginScreen2();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _LoginScreen2 extends State<LoginScreen2> {
  Duration get loginTime => Duration(milliseconds: 2250);
  String email = "";

  Future<String?> _authUser(LoginData data) async {
    //added async
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
            'Winter2022!!')); // in the future, password of database should not be used. how do i do this?
    try {
      var result = await conn.query(
          'select * from Active_Users where email = ? and password = ?',
          [data.name, calculatePassword(data.name, data.password)]);
      if ((result.isEmpty)) {
        return Future.delayed(loginTime).then((_) {
          return 'User Credentials incorrect';
        });
      } else {
        await FlutterSession().set('token', data.name);
        email = data.name;
        return Future.delayed(loginTime).then((_) {
          return null;
        });
      }
      // return true;
    } catch (e) {
      print(e);
      print("error was in add_row_to_friends.");
      // return false;
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
            'Winter2022!!')); // in the future, password of database should not be used. how do i do this?
    try {
      var results = await conn
          .query('select * from Active_Users where email = ?', [data.name]);
      if ((!results.isEmpty)) {
        return Future.delayed(loginTime).then((_) {
          return 'User already exists';
        });
      }

      var result = await conn.query(
          'insert into Active_Users (email, password, points, reports) values (?, ?, ?, ?)',
          [
            data.name,
            calculatePassword(data.name.toString(), data.password.toString()),
            0,
            0
          ]);
      // print('Inserted row id=${result.insertId}');
      await FlutterSession().set('token', data.name);
      email = stringToString(data.name);
      return Future.delayed(loginTime).then((_) {
        return null;
      });
    } catch (e) {
      print(e);
      print("error was in add_row_to_friends.");
      // return false;
      return Future.delayed(loginTime).then((_) {
        return null;
      });
    }
  }

  Future<String> _recoverPassword(String name) async {
    // this hasnt been tested yet
    debugPrint('Name: $name');
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
            'Winter2022!!')); // in the future, password of database should not be used. how do i do this?
    try {
      var result = await conn
          .query('select * from Active_Users where email = ?', [name]);
      if ((result.isEmpty)) {
        return Future.delayed(loginTime).then((_) {
          return 'User not exists';
        });
      } else {
        return 'null';
      }
      // return true;
    } catch (e) {
      print(e);
      return 'error in _recoverPassword, check login.dart';
      // return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'UVA Media',
      logo: const AssetImage('assets/TPP.PNG'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeView(
              user_email:
                  email), // this decides where user is taken after logging in  --------------------------------------------------
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
