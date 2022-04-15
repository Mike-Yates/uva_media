import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';
import 'package:uva_media/Screens/make_post.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(backgroundColor: Colors.amber),
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> _loadData() async {
    List posts = [];
    try {
      // const API = 'https://jsonplaceholder.typicode.com/posts';

      final conn = await MySqlConnection.connect(ConnectionSettings(
          host: 'mysql01.cs.virginia.edu',
          port: 3306,
          user: 'mjy5xy',
          db: 'mjy5xy',
          password: 'Winter2022!!'));
      var result = await conn.query('select * from Post');

      for (var row in result) {
        posts.add(row);
        // print('Name: ${row[0]}, email: ${row[1]}');
      }
      // final http.Response response = await http.get(Uri.parse(API));
      // posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }
    return posts;
  }

  String votes_to_string(int votes) {
    return votes.toString();
  }

  String dateTime_to_string(DateTime postTime) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    String answer = dateFormat.format(postTime);
    return answer.substring(0, 16); // cut off seconds
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UVA Media'),
      ),
      body: FutureBuilder(
          future: _loadData(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
                  .hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 220, 105, 11),
                        child: Text(
                            votes_to_string(snapshot.data![index]['votes'])),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data![index]['post_text'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      subtitle: Center(
                        child: Text(dateTime_to_string(
                            snapshot.data![index]['post_time'])),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.report,
                          color: Colors.red,
                        ),
                        iconSize: 40,
                        onPressed: () {},
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyCustomForm(),
                          ),
                        );
                      }, // should take the person to the comments page. this might be difficult to implement.
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyCustomForm(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
