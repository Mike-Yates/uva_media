import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';
import 'package:uva_media/functions/functions.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final myController2 = TextEditingController();
  String dropdownValue = 'Text';
  int postId = 0; // default to 0 because it doesnt allow null

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController2.dispose();
    super.dispose();
  }

  bool checkInput(text) {
    if (text == '') {
      return false;
    }
    if (text == null) {
      return false;
    }
    return true;
  }

  int post_idToInt(var inc) {
    return inc;
  }

  Future<bool> add_row_to_post(text) async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
            'Winter2022!!')); // in the future, password of database should not be used. how do i do this?

    try {
      var time = DateTime.now().toUtc();
      var type = dropdownValue;
      var result = await conn.query(
          'insert into Post (post_id, post_time, post_text, votes, post_report, post_type) values (?,?,?,?,?,? )',
          [null, time, text, 0, 0, type]);

      if (result.insertId != null) {
        postId = post_idToInt(result.insertId);
        print(postId);
        print(widget.email);
      } else {
        // we got problems
      }
      //************************************************
      // Inserts into Post_Creator.  Need to retrieve email and password from active session.
      // Need to get the autoincrement value

      var result2 = await conn.query(
          'insert into Post_Creators (post_id, email) values (?,?)',
          [postId, widget.email]);

      //************************************************
      // Inserts specific types of posts.
      // Need to get the autoincrement value

      if (type == "Text") {
        var text_res = await conn.query(
            'insert into Text_Post (post_id, color) values (?,?)',
            [postId, "red"]);
      }
      if (type == "Image") {
        var image_res = await conn.query(
            'insert into Images (post_id, content) values (?,?)',
            [postId, "url"]);
      }
      if (type == "Video") {
        var video_res = await conn.query(
            'insert into Videos (post_id, content) values (?,?)',
            [postId, "url"]);
      }
      if (type == "Poll") {
        var poll_res = await conn.query(
            'insert into Poll_Post (post_id, num_options) values (?,?)',
            [postId, "option num"]);
      }
      //************************************************
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
    String email = widget.email;
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
                  items: <String>['Text', 'Image', 'Video', 'Poll']
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
                        bool input_correctness = checkInput(myController2.text);
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
                          if (dropdownValue == "Text") {
                            openTextPopup(context);
                            add_row_to_post(myController2.text);
                          } else if (dropdownValue == "Image") {
                            openImagePopup(context);
                            add_row_to_post(myController2.text);
                          } else if (dropdownValue == "Video") {
                            openVideoPopup(context);
                            add_row_to_post(myController2.text);
                          } else {
                            openPollPopup(context);
                            add_row_to_post(myController2.text);
                          }
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
