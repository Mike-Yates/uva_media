import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';

String votesToString(int votes) {
  return votes.toString();
}

String dateTimeToString(DateTime postTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  String answer = dateFormat.format(postTime);
  return answer.substring(0, 16); // cut off seconds
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
