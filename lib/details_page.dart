import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordpress_2/models/post.dart';

class DetailsPage extends StatelessWidget {

  Post post;

  DetailsPage(this.post);

  _getPostImage() {
    if (post.image == null) {
      return SizedBox(height: 10,);
    } else {
      return Image.network(post.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),    
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Text(
                post.title.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22
                ),
              ),
              SizedBox(height: 10,),
              _getPostImage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(post.date.replaceAll('T', ' ')),
                  Text(post.author.toString())
                ],
              ),
              SizedBox(height: 10,),
              Html(
                data: post.content,
                onLinkTap: (String url) {
                  _launchUrl(url);
                },
              )
            ],
          ),
        )
      ),
    );
  }
}

_launchUrl(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Cannot launch $link';
  }
}