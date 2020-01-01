class Post {
  final int id;
  final String title;
  final String author;
  final String excerpt;
  final String date;
  final String content;
  final String image;
  bool isSaved = false;

  Post(
    {
      this.content,
      this.id,
      this.title,
      this.excerpt,
      this.date,
      this.image,
      this.author,
    }
  );

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title']['rendered'],
      content: json['content']['rendered'],
      date: json['date'] != null
        ? json['date'].toString().replaceFirst('T', ' ')
        : null,
      image: json['_links']['wp:featuredmedia'] != null
        ? json['_links']['wp:featuredmedia'][0]['href']
        : null,
      excerpt: json['excerpt']['rendered'],
      author: json['author'].toString()
    );
  }
}