import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/interface/detail_article_page.dart';
import 'package:healthy_life_buddy/provider/article_provider.dart';
import 'package:healthy_life_buddy/widget/error_state_message.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/no_data_state_message.dart';
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
    return Consumer<ArticleProvider>(
      builder: (context, snapshot, _) {
        final articleData = snapshot.article;
        var currentState = snapshot.state;
        if (currentState == CurrentState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (currentState == CurrentState.hasData ||
            currentState == CurrentState.isSuccsess) {
          return ListView.builder(
            itemCount: articleData.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () async {
                  await Provider.of<ArticleProvider>(context, listen: false)
                      .getCurrentReviewStatus(articleData[i].id);
                  await Provider.of<ArticleProvider>(context, listen: false)
                      .getReviewCount(articleData[i].id);
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
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      articleData[i].imageUrl,
                                      height: 125,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          articleData[i].title,
                                          style: textTheme.headline6?.apply(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface),
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
                                              style: textTheme.caption?.apply(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                            ),
                                          ),
                                          Text(
                                            "|",
                                            style: textTheme.bodyText1?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              DateFormat('dd-MM-yyyy')
                                                  .format(
                                                    DateTime.fromMillisecondsSinceEpoch(
                                                        articleData[i]
                                                            .createAt
                                                            .millisecondsSinceEpoch),
                                                  )
                                                  .toString(),
                                              style: textTheme.caption?.apply(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          articleData[i].content,
                                          style: textTheme.bodyText2?.apply(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.thumb_up,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Text(
                                            snapshot.article[i].like.toString(),
                                            style: textTheme.subtitle1?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Icon(
                                              Icons.thumb_down,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Text(
                                            snapshot.article[i].dislike
                                                .toString(),
                                            style: textTheme.subtitle1?.apply(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
          return const NoDataStateMessage();
        } else {
          return const ErrorStateMessage();
        }
      },
    );
  }
}
