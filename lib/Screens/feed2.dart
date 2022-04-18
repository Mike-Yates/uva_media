import 'package:flutter/material.dart';
import 'package:uva_media/Screens/DashBoard.dart';
import 'package:uva_media/Screens/make_post.dart';
import 'package:uva_media/Screens/DetailScreen.dart';
import 'package:uva_media/functions/functions.dart';
import 'package:uva_media/deprecated/flutter_session/flutter_session.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.user_email}) : super(key: key);
  final String user_email;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UVA Media'),
      ),
      body: FutureBuilder(
          future:
              loadAllPostsTest(), // loadAllPostsAndUserLikes(widget.user_email), // // loadAllPostsTest(),
          builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) => snapshot
                  .hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 220, 105, 11),
                        child:
                            Text(votesToString(snapshot.data![index]['votes'])),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(snapshot.data![index]['post_text'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(dateTimeToString(
                              snapshot.data![index]['post_time'])),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_circle_down_rounded,
                              color: Colors.green,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              // ckeck if user has already voted
                              // snapshot.data![index]['votes'] = snapshot.data![index]['votes'] - 1;
                              // setPostVote(postId, newVoteCount);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_circle_up_rounded,
                              color: (boolToBool(snapshot.data![index]['liked'])
                                  ? Colors.green
                                  : Colors.red),
                              // color: Colors.green,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              print(snapshot.data![index]['liked']);
                            },
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                postId: snapshot.data![index]['post_id'],
                                postText: snapshot.data![index]
                                    ['post_text']), // MyCustomForm DashBoard
                          ),
                        );
                      },
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
              builder: (context) =>
                  MyCustomForm(email: widget.user_email), // fix
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
