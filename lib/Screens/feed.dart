import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UVA Media"),
      ),
      body: _postListView(),
    );
  }


  Widget _postText(user_text, post_text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: ListTile(
          title: Text(user_text,
            style: TextStyle(fontWeight: FontWeight.bold
            ),
          ),
          subtitle: Text(post_text)
      ),
    );
  }

  Widget _postCommentButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          "Comments",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
    );
  }

  Widget _postView(user_text, post_text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ _postText(user_text, post_text), _postCommentButton()],
    );
  }

  Future<Object> _postPull() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
        'Winter2022!!')); // in the future, password of database should not be used. how do i do this?
    try {
      var result = await conn
          .query('select post_id, post_text from Post');
      return result;
    } catch (e) {
      print(e);
      return e;
      // return false;
    }
  }

  Future<Object> _postNum() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password:
        'Winter2022!!')); // in the future, password of database should not be used. how do i do this?
    try {
      var count = await conn
          .query('SELECT COUNT(*) FROM Post');
      return count;
    } catch (e) {
      print(e);
      return e;
      // return false;
    }
  }

  Widget _postListView() {
    var result = _postPull();
    var num = _postNum().toString();
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return _postView(num,
              "Look at all these posts!!! So cool!!! I love UVA media so much! More text to see how it looks? Yes please!");
        });
  }
}