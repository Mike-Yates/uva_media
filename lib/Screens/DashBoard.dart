import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';

// import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';

import 'login.dart';
import 'make_post.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(children: <Widget>[
          FutureBuilder(
              future: FlutterSession().get('token'),
              builder: (context, snapshot) {
                return Text(
                    snapshot.hasData ? snapshot.data.toString() : 'loading...');
              }),
          Center(
              child: MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    FlutterSession().set('token', '');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Logout'))),
          MaterialButton(
              color: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCustomForm(),
                  ),
                );
              },
              child: Text('Another page')),
        ]));
  }
  // Create a text controller and use

}
