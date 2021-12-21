import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/article_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/article_model.dart';

enum ReviewState { like, dislike, none }

class ArticleProvider with ChangeNotifier {
  ArticleProvider() {
    fetchArticleList();
  }

  late CurrentState _state;
  late ReviewState _reviewState;
  late int _like;
  late int _dislike;
  List<Article> _articleList = [];

  int get like => _like;
  int get dislike => _dislike;
  CurrentState get state => _state;
  ReviewState get reviewState => _reviewState;
  List<Article> get article => _articleList;

  fetchArticleList() async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final articleList = await getArticle();
      if (articleList.isNotEmpty) {
        _state = CurrentState.hasData;
        _articleList = articleList;
        notifyListeners();
      } else if (articleList.isEmpty) {
        _state = CurrentState.noData;
        notifyListeners();
      }
    } catch (e) {
      _state = CurrentState.isError;
      notifyListeners();
    }
  }

  getReviewCount(String articleId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("article")
        .doc(articleId)
        .get();
    _like = snapshot.data()!["like"];
    _dislike = snapshot.data()!["dislike"];
  }

  getCurrentReviewStatus(String articleId) async {
    final reviewStatus = await getReviewStatus(articleId);
    if (reviewStatus == "like") {
      _reviewState = ReviewState.like;
    } else if (reviewStatus == "dislike") {
      _reviewState = ReviewState.dislike;
    } else {
      _reviewState = ReviewState.none;
    }
    notifyListeners();
  }

  articleReviewLike(String articleId) async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final reviewStatus = await getReviewStatus(articleId);
      if (reviewStatus == "like") {
        await removeLikeData(articleId);
        await setUserReviewStatus(articleId, "none");
        _reviewState = ReviewState.none;
      } else if (reviewStatus == "dislike") {
        await removeDislikeData(articleId);
        await setLikeData(articleId);
        await setUserReviewStatus(articleId, "like");
        _reviewState = ReviewState.like;
      } else {
        await setLikeData(articleId);
        await setUserReviewStatus(articleId, "like");
        _reviewState = ReviewState.like;
      }
      await getReviewCount(articleId);
      _state = CurrentState.isSuccsess;
      fetchArticleList();
      notifyListeners();
    } catch (e) {
      _state = CurrentState.isError;
      notifyListeners();
    }
  }

  articleReviewDislike(String articleId) async {
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final reviewStatus = await getReviewStatus(articleId);
      if (reviewStatus == "like") {
        await removeLikeData(articleId);
        await setDislikeData(articleId);
        await setUserReviewStatus(articleId, "dislike");
        _reviewState = ReviewState.dislike;
      } else if (reviewStatus == "dislike") {
        await removeDislikeData(articleId);
        await setUserReviewStatus(articleId, "none");
        _reviewState = ReviewState.none;
      } else {
        await setDislikeData(articleId);
        await setUserReviewStatus(articleId, "dislike");
        _reviewState = ReviewState.dislike;
      }
      await getReviewCount(articleId);
      _state = CurrentState.isSuccsess;
      fetchArticleList();
      notifyListeners();
    } catch (e) {
      _state = CurrentState.isError;
      notifyListeners();
    }
  }
}
