import 'package:flutter/material.dart';
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("UVA Media"),
      ),
      body: _postListView(),
    );
  }

<<<<<<< HEAD
  Widget _postAuthorRow(){
    return Text(
      "username",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }
=======
>>>>>>> master

  Widget _postText(){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
<<<<<<< HEAD
      child: Text(
        "Look at all these posts!!! So cool!!! I love UVA media so much! More text to see how it looks? Yes please!"
=======
      child: ListTile(
        title: Text("username",
          style: TextStyle(fontWeight: FontWeight.bold
        ),
      ),
        subtitle: Text("Look at all these posts!!! So cool!!! I love UVA media so much! More text to see how it looks? Yes please!")
>>>>>>> master
      ),
    );
  }

  Widget _postCommentButton(){
    return Padding(
<<<<<<< HEAD
      padding: const EdgeInsets.symmetric(horizontal: 8),
=======
      padding: const EdgeInsets.symmetric(horizontal: 45),
>>>>>>> master
      child: GestureDetector(
        onTap: () {},
        child: Text(
          "Comments",
          style: TextStyle(fontWeight: FontWeight.w200),
        ),
      ),
    );
  }

  Widget _postView(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
<<<<<<< HEAD
      children: [_postAuthorRow(), _postText(), _postCommentButton()],
=======
      children: [ _postText(), _postCommentButton()],
>>>>>>> master
    );
  }

  Widget _postListView(){
    return ListView.builder(
<<<<<<< HEAD
      itemCount: 30,
=======
      itemCount: 3,
>>>>>>> master
      itemBuilder: (context, index){
        return _postView();
      });
  }
}