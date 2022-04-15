import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uva_media/functions/functions.dart';

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({Key? key, required this.postId, required this.postText})
      : super(key: key);

  // Declare a field that holds the postId.
  final int postId;
  final String postText;

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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Text(
                postText,
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
                textScaleFactor: 2,
              ),
            ),
            SizedBox(height: 25),
            FutureBuilder(
                future: loadAllComments(postId),
                builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                    snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, index) => Card(
                              margin: const EdgeInsets.all(5),
                              child: ListTile(
                                /*leading: CircleAvatar(
                                  backgroundColor:
                                      Color.fromARGB(255, 220, 105, 11),
                                  child: Text(votesToString(
                                      snapshot.data![index]['votes'])),
                                ),*/
                                contentPadding: const EdgeInsets.all(10),
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      snapshot.data![index]['comment_text'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                ),
                                subtitle: Center(
                                  child: Text(dateTimeToString(
                                      snapshot.data![index]['comment_time'])),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.report,
                                    color: Colors.red,
                                  ),
                                  iconSize: 40,
                                  onPressed: () {},
                                ),
                                onTap: () {},
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
          ],
        ),
      ),
    );
  }
}
