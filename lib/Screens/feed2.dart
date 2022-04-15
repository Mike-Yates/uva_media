import 'package:flutter/material.dart';
import 'package:uva_media/Screens/DashBoard.dart';
import 'package:uva_media/Screens/make_post.dart';
import 'package:uva_media/Screens/DetailScreen.dart';
import 'package:uva_media/functions/functions.dart';

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
      title: 'UVA Media',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UVA Media'),
      ),
      body: FutureBuilder(
          future: loadAllPosts(),
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
