import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:mysql1/mysql1.dart';

Future main() async {
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'mysql01.cs.virginia.edu',
      port: 3306,
      user: 'mjy5xy', // root didnt work
      db: 'mjy5xy',
      password: 'Winter2022!!'));

  await conn.close();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  /*
  bool add_row_to_friends(name, major, year) {
    var result = await conn.query(
      'insert into friends (name, major, year) values (?, ?, ?)',
      [myController.text, myController2.text, myController3.text]);
      print('Inserted row id=${result.insertId}');


    return true; 
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friend Book', textAlign: TextAlign.center),
        backgroundColor: Colors.teal[800],
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Name:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    // backgroundColor: Colors.black.withOpacity(0.5),
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: myController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.teal[800],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Major:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    // backgroundColor: Colors.black.withOpacity(0.5),
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: myController2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.teal[800],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Year:',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    // backgroundColor: Colors.black.withOpacity(0.5),
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: myController3,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.teal[800],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {},
                      child: Text('Add', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 25.0),
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {},
                      child: Text('Confirm Update',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )

                //Expanded(
                //  flex: 1,
                // child: Image.asset('assets/squad.jpg')
                //),
                //SizedBox(height: 50.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
