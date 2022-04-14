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

  Widget _postAuthorRow(){
    return Text(
      "username",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }

  Widget _postText(){
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Text(
        "Look at all these posts!!! So cool!!! I love UVA media so much! More text to see how it looks? Yes please!"
      ),
    );
  }

  Widget _postCommentButton(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
      children: [_postAuthorRow(), _postText(), _postCommentButton()],
    );
  }

  Widget _postListView(){
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index){
        return _postView();
      });
  }
}