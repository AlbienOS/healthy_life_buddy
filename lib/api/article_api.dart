import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/model/article_model.dart';
import 'package:healthy_life_buddy/model/detail_sports_venue_model.dart';

Future<List<Article>> getArticle() async {
  final snapshot = await FirebaseFirestore.instance.collection('article').get();
  List<Article> _articleList = [];
  _articleList = snapshot.docs.map((data) => Article.fromObject(data)).toList();
  print('data lenght : ${_articleList}');
  return _articleList;
}

Future<Article> getDetailArticle(String id) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('article').doc(id).get();
  Article _detailArticle;
  _detailArticle = Article.fromObject(snapshot);
  return _detailArticle;
}
