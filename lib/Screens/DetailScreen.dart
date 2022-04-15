import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:uva_media/functions/functions.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.postId, required this.postText})
      : super(key: key);

  // Declare a field that holds the postId.
  final int postId;
  final String postText;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: FutureBuilder(
          future: loadAllComments(widget.postId),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
              snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) => Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data![index]['comment_text'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                          subtitle: Row(
                            children: <Widget>[
                              Text(dateTimeToString(
                                  snapshot.data![index]['comment_time'])),
                              SizedBox(width: 10),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_circle_down_rounded,
                                  color: Colors.green,
                                ),
                                iconSize: 40,
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_circle_up_rounded,
                                  color: Colors.green,
                                ),
                                iconSize: 40,
                                onPressed: () {},
                              ),
                            ],
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
    );
  }
}
