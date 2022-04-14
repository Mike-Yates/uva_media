import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/make_post.dart';

const users = {
  'JHurst@gmail.com': 'BoringPassword123',
  'Yates@gmail.com': 'GoatTalk',
};

// todo: change username to phone number
// referenced https://pub.dev/packages/flutter_login
class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User does not exist';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null; // for now, just return to the login page
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return 'null';
    });
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
