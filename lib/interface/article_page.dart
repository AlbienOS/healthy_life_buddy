import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/detail_article_page.dart';
import 'package:healthy_life_buddy/provider/article_provider.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  static const routeName = '/ArticlePage';
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              UserProfile(),
              Headline(text: "Discover Article"),
              Expanded(
                child: ListOfArticles(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListOfArticles extends StatelessWidget {
  const ListOfArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArticleProvider(),
      child: Consumer<ArticleProvider>(
        builder: (context, snapshot, _) {
          final articleData = snapshot.article;
          var currentState = snapshot.state;
          if (currentState == CurrentState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (currentState == CurrentState.hasData) {
            return ListView.builder(
              itemCount: articleData.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailArticlePage(articleData: articleData[i]);
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    articleData[i].imageUrl,
                                    width: 85,
                                    height: 85,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        articleData[i].title,
                                        style: textTheme.headline6
                                            ?.apply(color: onSurfaceColor),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            articleData[i]
                                                .authorImageProfileUrl,
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            articleData[i].author,
                                            style: textTheme.caption
                                                ?.apply(color: onSurfaceColor),
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyyy')
                                              .format(
                                                DateTime.fromMillisecondsSinceEpoch(
                                                    articleData[i]
                                                        .createAt
                                                        .millisecondsSinceEpoch),
                                              )
                                              .toString(),
                                          style: textTheme.caption
                                              ?.apply(color: onSurfaceColor),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        articleData[i].content,
                                        style: textTheme.caption
                                            ?.apply(color: onSurfaceColor),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (currentState == CurrentState.noData) {
            return Text("no data");
          } else {
            return Text("error");
          }
        },
      ),
    );
  }
}
