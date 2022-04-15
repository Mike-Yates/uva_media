import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uva_media/functions/functions.dart';

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({Key? key, required this.postId}) : super(key: key);

  // Declare a field that holds the postId.
  final String postId;

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
      var result =
          await conn.query('select * from Post where post_id = ?', [postId]);

      for (var row in result) {
        posts.add(row);
      }
    } catch (err) {
      print(err);
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            FutureBuilder(
                future: _loadData(),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? Text("working")
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
          ],
        ),
      ),
    );
  }
}
