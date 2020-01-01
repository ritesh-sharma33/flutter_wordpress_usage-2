import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wordpress_2/models/post.dart';
import 'dart:convert';
import 'package:wordpress_2/widgets/post_card.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  String url = "https://demo.wp-api.org/wp-json/wp/v2/posts";
  bool isLoading = false;
  List<Post> posts = List();

  @override
  void initState() {
    _fetchPosts();
    super.initState();
  }

  Future<void> _fetchPosts() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(this.url);
    if (response.statusCode == 200) {
      posts = (json.decode(response.body) as List).map((data) {
        return Post.fromJSON(data);
      }).toList();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Wordpress Demo API App part - 2"),
          centerTitle: true,
          backgroundColor: Colors.orange,
        ),
        body: this.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: posts.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[PostCard(post: posts[index])],
                  );
                },
              ));
  }
}
