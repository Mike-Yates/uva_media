import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/make_post.dart';
import 'package:mysql1/mysql1.dart';

const users = {
  'JHurst@gmail.com': 'BoringPassword123',
  'Yates@gmail.com': 'GoatTalk',
};

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreen createState() => _LoginScreen();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _LoginScreen extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);

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
      var result = await conn
          .query('select * from Active_Users where email = ?', [data.name]);
      if ((result.isEmpty)) {
        return Future.delayed(loginTime).then((_) {
          return 'User not exists';
        });
      } else {
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
    /* 
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null; // for now, just return to the login page
    }); */
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) async {
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
          builder: (context) =>
              MyCustomForm(), // this decides where user is taken after logging in  --------------------------------------------------
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
