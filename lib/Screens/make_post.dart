import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';

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

  bool checkInput(name, major, year) {
    if (name == '' || major == '' || year == '') {
      return false;
    }
    if (name == null || major == null || year == null) {
      return false;
    }
    try {
      int.parse(year);
    } catch (e) {
      return false;
    }
    int x = int.parse(year);
    if (x > 4 || x < 0) {
      return false;
    }
    return true;
  }

  Future<bool> add_row_to_friends(name, major, year) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
            'Winter2022!!')); // in the future, password of database should not be used. how do i do this?
    try {
      var result = await conn.query(
          'insert into friends (name, major, year) values (?, ?, ?)',
          [name, major, year]);
      print('Inserted row id=${result.insertId}');
      myController.clear();
      myController2.clear();
      myController3.clear();
      return true;
    } catch (e) {
      print(e);
      print("error was in add_row_to_friends.");
      return false;
    }
  }

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

                FutureBuilder(
                    future: FlutterSession().get('token'),
                    builder: (context, snapshot) {
                      return Text(snapshot.hasData
                          ? snapshot.data
                              .toString() // snapshot.data.toString() // this gets printed, suggesting that the snapshot has data. although it doesnt show
                          : 'loading...'); // snapshot.data.toString()
                    }),

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
                      onPressed: () {
                        bool input_correctness = checkInput(myController.text,
                            myController2.text, myController3.text);
                        if (!input_correctness) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Incorrect Input. Please Fix. "),
                              );
                            },
                          );
                        } else {
                          add_row_to_friends(myController.text,
                              myController2.text, myController3.text);
                        }
                      },
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
