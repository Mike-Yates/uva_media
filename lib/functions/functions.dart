import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mysql1/mysql1.dart';

// INSERT INTO `Liked_Posts` (`post_id`, `username`, `liked`) VALUES ('4', 'mike@gmail.com', '1');

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

Future<List> loadAllPostsAndUserLikes(String username) async {
  List posts = [];
  List posts2 = [];
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
    var result2 = await conn
        .query('select * from Liked_Posts where username = ?', [username]);
    for (var row2 in result2) {
      posts2.add(row2);
    }

    for (var j = 0; j < posts.length; j++) {
      // for each row in Posts
      bool exists = false;
      for (var i = 0; i < posts2.length; i++) {
        // for each in Liked_Posts
        // check if row’s post id is equal to the row’s post id
        if (posts2[i]['post_id'] == posts[j]['post_id']) {
          // if they both have the same post id, it means the user has either liked or disliked the post.
          exists = true;
          if (posts2[i]['liked']) {
            // this is either 1 (true) or 0 (false)
            // if its true, the user has liked this post.
            // append to list
            posts[j]['liked'] = true;
            posts[j]['disliked'] = false;
          } else {
            // this means user disliked post
            posts[j]['liked'] = false;
            posts[j]['disliked'] = true;
          }
        }
      }
      if (!exists) {
        // if the posts wasnt found in liked_posts,
        posts[j]['liked'] = false;
        posts[j]['disliked'] = false;
      }
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
