import 'package:flutter/material.dart';
import 'package:wordpress_2/details_page.dart';
import 'package:wordpress_2/models/post.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class PostCard extends StatelessWidget {

  final Post post;

  PostCard({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailsPage(post);
              },
              fullscreenDialog: true
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            post.image != null
              ? Image.network(post.image)
              : SizedBox(),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Html(
                data: post.title,
                defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Html(
                data: post.excerpt,
                defaultTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 18
                ),
                onLinkTap: (String link) {
                  _launchUrl(link);
                },
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    post.date.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue
                    ),
                  ),
                  Text(
                    post.author.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,)
          ],
        ),
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