import 'package:flutter/material.dart';

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
          title: Text(
            user_text,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(post_text)),
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
      children: [_postText(user_text, post_text), _postCommentButton()],
    );
  }

  Widget _postListView() {
    return ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return _postView("username",
              "Look at all these posts!!! So cool!!! I love UVA media so much! More text to see how it looks? Yes please!");
        });
  }
}
