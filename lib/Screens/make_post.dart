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
  String dropdownValue = 'Text';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    super.dispose();
  }

  bool checkInput(text, type) {
    if (text == '' || type == '') {
      return false;
    }
    if (text == null || type == null) {
      return false;
    }
    return true;
  }


  Future<bool> add_row_to_post(type, text) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
            'Winter2022!!')); // in the future, password of database should not be used. how do i do this?

    try {
      var time = DateTime.now().toUtc();
      var result = await conn.query(
          'insert into Post (post_id, post_time, post_text, votes, post_report, post_type) values (?,?,?,?,?,? )',
          [null, time, text, 0, 0, type]);
      var result2 = await conn.query(
          'insert into Post_Creator2 (email, pass, post_id) values (?,?,?)',
          ["email", "password", 0]);
      //**********need to fix this**************//
      myController.clear();
      myController2.clear();
      return true;
    } catch (e) {
      print(e);
      print("error was in add_row_to_post.");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post', textAlign: TextAlign.center),
        backgroundColor: Colors.blue,
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
                  'Post Type: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    // backgroundColor: Colors.black.withOpacity(0.5),
                    fontSize: 20,
                  ),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Text', 'Image', 'Video', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 30.0),
                Text(
                  'Text: ',
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
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        bool input_correctness =
                            checkInput(myController.text, myController2.text);
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
                          add_row_to_post(
                              myController.text, myController2.text);
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
