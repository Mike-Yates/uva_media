import 'package:flutter/material.dart';

// import this to be able to call json.decode()
import 'dart:convert';

// import this to easily send HTTP request
import 'package:http/http.dart' as http;

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
      // This is an open REST API endpoint for testing purposes
      const API = 'https://jsonplaceholder.typicode.com/posts';

      final http.Response response = await http.get(Uri.parse(API));
      posts = json.decode(response.body);
    } catch (err) {
      print(err);
    }

    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kindacode.com'),
        ),
        body: FutureBuilder(
            future: _loadData(),
            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>
                snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, index) => Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(snapshot.data![index]['title']),
                            subtitle: Text(snapshot.data![index]['body']),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )));
  }
}
