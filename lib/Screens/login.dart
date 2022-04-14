import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:flutter_login/flutter_login.dart'; // has dependency issues with flutter sessions unfortunately
import 'package:uva_media/screens/home.dart';
import 'package:uva_media/screens/make_post.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mysql1/mysql1.dart';
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
    // pass through some type of check input function

    var data = '';
    // for now, add a user instea dof querrying to see if the user already exists
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
            'Winter2022!!')); // in the future, password of database should not be used. how do i do this?
    try {
      var result = await conn.query(
          'insert into Active_Users (email, password, points, reports) values (?, ?, ?, ?)',
          [user.text, pass.text, 0, 0]);
      print('Inserted row id=${result.insertId}');
      user.clear();
      pass.clear();
      data = "Success";
      // return true;
    } catch (e) {
      print(e);
      print("error was in add_row_to_friends.");
      // return false;
    }

    // change this
    /*
    var url = Uri.parse("http:gg.php");
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    // var data = json.decode(response.body);
    */

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
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                    color: Colors.amber,
                    elevation: 5,
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: user,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: pass,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                  color: Colors.blue,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    login();
                                  }),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: MaterialButton(
                                  color: Colors.blue,
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {}),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    )))
          ],
          // missing material button
        ));
  }
}
