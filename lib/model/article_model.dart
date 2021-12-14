import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  late String id;
  late String author;
  late String authorImageProfileUrl;
  late String content;
  late Timestamp createAt;
  late String imageUrl;
  late int like;
  late String title;

  Article.fromObject(DocumentSnapshot<Map<String, dynamic>> data) {
    id = data.id;
    author = data['author'];
    authorImageProfileUrl = data['authorImageProfileUrl'];
    content = data['content'];
    createAt = data['createAt'];
    imageUrl = data['imageUrl'];
    like = data['like'].toInt();
    title = data['title'];
  }
}
