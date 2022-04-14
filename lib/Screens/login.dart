import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:flutter_login/flutter_login.dart'; // has dependency issues with flutter sessions unfortunately
import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/make_post.dart';

// import 'package:flutter_session/flutter_session.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';

import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:convert/convert.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<LoginScreen> {
  // referenced https://www.youtube.com/watch?v=W2WeZaqNB2o
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  Future login() async {
    // change this
    var url = Uri.parse("http:gg.php");
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });

    var data = json.decode(response.body);
    if (data == "Success") {
      // toast saying successful login, 1:51

      // assign the users email as their token
      await FlutterSession().set('token', user.text);
      Fluttertoast.showToast(
        // context
        msg: 'Login Successful',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        fontSize: 16,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyCustomForm(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        // removed (context) after Fluttertoast
        msg: 'Login Failed, Wrong Credentials',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        fontSize: 16,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("UVA Media"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: <Widget>[
            FutureBuilder(
                future: FlutterSession().get('token'),
                builder: (context, snapshot) {
                  return Text(snapshot.hasData
                      ? snapshot.data.toString()
                      : 'loading...');
                }),
            TextButton(
              child: Text('login',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Register',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  )),
              onPressed: () {},
            )
          ],
          // missing material button
        ));
  }
}
