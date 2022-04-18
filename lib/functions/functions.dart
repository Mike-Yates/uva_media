import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String votesToString(int votes) {
  return votes.toString();
}

String dateTimeToString(DateTime postTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String answer = dateFormat.format(postTime);
  return answer.substring(0, 16); // cut off seconds
}

String stringToString(var toChange) {
  return toChange;
}

Future<List> loadAllPosts() async {
  List posts = [];
  try {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password: 'Winter2022!!'));
    var result = await conn.query('select * from Post');
    for (var row in result) {
      posts.add(row);
    }
  } catch (err) {
    print(err);
  }
  return posts;
}

Future<List> loadAllComments(int postId) async {
  List posts = [];
  try {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'mysql01.cs.virginia.edu',
        port: 3306,
        user: 'mjy5xy',
        db: 'mjy5xy',
        password: 'Winter2022!!'));
    var result =
        await conn.query('select * from Comment where post_id = ?', [postId]);
    for (var row in result) {
      posts.add(row);
    }
  } catch (err) {
    print(err);
  }
  return posts;
}

openTextPopup(context) {
  Alert(
      context: context,
      title: "Select Color: ",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Color: ',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ]).show();
}

openImagePopup(context) {
  Alert(
      context: context,
      title: "Insert Media: ",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Image URL: ',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ]).show();
}

openVideoPopup(context) {
  Alert(
      context: context,
      title: "Insert Media: ",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Video URL: ',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        )
      ]).show();
}

