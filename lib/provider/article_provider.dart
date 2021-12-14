import 'package:flutter/cupertino.dart';
import 'package:healthy_life_buddy/api/article_api.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/model/article_model.dart';

class ArticleProvider with ChangeNotifier {
  ArticleProvider() {
    fetchArticleList();
  }

  late CurrentState _state;
  List<Article> _articleList = [];

  List<Article> get article => _articleList;
  CurrentState get state => _state;

  fetchArticleList() async {
    print("loading data article");
    _state = CurrentState.isLoading;
    notifyListeners();
    try {
      final articleList = await getArticle();
      print("data lenght: ${articleList.length}");
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
      print(e.toString());
      notifyListeners();
    }
  }
}
