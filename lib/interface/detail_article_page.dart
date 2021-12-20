import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/model/article_model.dart';
import 'package:healthy_life_buddy/provider/article_provider.dart';
import 'package:healthy_life_buddy/widget/back_button.dart';
import 'package:healthy_life_buddy/widget/share_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailArticlePage extends StatelessWidget {
  const DetailArticlePage({Key? key, required this.articleData})
      : super(key: key);

  final Article articleData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ArticleContent(
                    articleData: articleData,
                  ),
                ),
                Row(
                  children: [
                    Consumer<ArticleProvider>(
                      builder: (context, snapshot, _) {
                        final articleReviewState = snapshot.reviewState;
                        final state = snapshot.state;
                        return Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                child: IconButton(
                                  onPressed: () async {
                                    if (state != CurrentState.isLoading) {
                                      await snapshot
                                          .articleReviewLike(articleData.id);
                                    }
                                  },
                                  icon: Icon(
                                    articleReviewState == ReviewState.like
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            Text(snapshot.like.toString()),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Container(
                                child: IconButton(
                                  onPressed: () async {
                                    if (state != CurrentState.isLoading) {
                                      await snapshot
                                          .articleReviewDislike(articleData.id);
                                    }
                                  },
                                  icon: Icon(
                                    articleReviewState == ReviewState.dislike
                                        ? Icons.thumb_down
                                        : Icons.thumb_down_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            ),
                            Text(snapshot.dislike.toString()),
                          ],
                        );
                      },
                    ),
                    ShareButton(
                        text:
                            "ayo baca artikel yang sangat informatif yang berjudul ${articleData.title} yang ditulis oleh ${articleData.author}",
                        subjectText: "ayo baca ${articleData.title}")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ArticleContent extends StatelessWidget {
  const ArticleContent({Key? key, required this.articleData}) : super(key: key);

  final Article articleData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                articleData.title,
                style: textTheme.headline5
                    ?.apply(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(articleData.authorImageProfileUrl,
                            width: 25, height: 25, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          articleData.author,
                          style: textTheme.subtitle1?.apply(
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      " | ",
                      style: textTheme.subtitle1?.apply(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      DateFormat('dd-MM-yyyy')
                          .format(
                            DateTime.fromMillisecondsSinceEpoch(
                                articleData.createAt.millisecondsSinceEpoch),
                          )
                          .toString(),
                      style: textTheme.caption?.apply(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  articleData.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                articleData.content,
                style: textTheme.caption
                    ?.apply(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
