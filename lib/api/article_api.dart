import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_life_buddy/api/auth_api.dart';
import 'package:healthy_life_buddy/model/article_model.dart';

Future<List<Article>> getArticle() async {
  final snapshot = await FirebaseFirestore.instance.collection('article').get();
  List<Article> _articleList = [];
  _articleList = snapshot.docs.map((data) => Article.fromObject(data)).toList();
  return _articleList;
}

Future<Article> getDetailArticle(String id) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('article').doc(id).get();
  Article _detailArticle;
  _detailArticle = Article.fromObject(snapshot);
  return _detailArticle;
}

Future<String?> getReviewStatus(String articleId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(auth.currentUser!.uid)
      .collection("review_status")
      .doc(articleId)
      .get();
  return snapshot.data()?["review_state"];
}

setUserReviewStatus(String articleId, String status) async {
  await FirebaseFirestore.instance
      .collection("users")
      .doc(auth.currentUser!.uid)
      .collection("review_status")
      .doc(articleId)
      .set({
    "review_state": status,
  });
}

setLikeData(String articleId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('article')
      .doc(articleId)
      .get();
  FirebaseFirestore.instance.collection('article').doc(articleId).update(
    {
      "like": snapshot.data()!["like"].toInt() + 1,
    },
  );
}

removeLikeData(String articleId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('article')
      .doc(articleId)
      .get();
  FirebaseFirestore.instance.collection('article').doc(articleId).update(
    {
      "like": snapshot.data()!["like"].toInt() - 1,
    },
  );
}

setDislikeData(String articleId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('article')
      .doc(articleId)
      .get();
  FirebaseFirestore.instance.collection('article').doc(articleId).update(
    {
      "dislike": snapshot.data()!["dislike"].toInt() + 1,
    },
  );
}

removeDislikeData(String articleId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('article')
      .doc(articleId)
      .get();
  FirebaseFirestore.instance.collection('article').doc(articleId).update(
    {
      "dislike": snapshot.data()!["dislike"].toInt() - 1,
    },
  );
}
