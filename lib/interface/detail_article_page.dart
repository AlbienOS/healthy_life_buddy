import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/color_style.dart';
import 'package:healthy_life_buddy/common/text_style.dart';
import 'package:healthy_life_buddy/model/article_model.dart';
import 'package:healthy_life_buddy/widget/back_button.dart';
import 'package:healthy_life_buddy/widget/share_button.dart';
import 'package:intl/intl.dart';

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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.thumb_up_outlined,
                            color: primaryColor,
                          ),
                        ),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            color: surfaceColor,
                            borderRadius: BorderRadius.circular(100)),
                      ),
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
              child: Text(articleData.title, style: textTheme.headline5),
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
                        child: Text(articleData.author,
                            style: textTheme.subtitle1),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(" | "),
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
                        style: textTheme.caption),
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
              child: Text(articleData.content, style: textTheme.caption),
            ),
          ],
        ),
      ),
    );
  }
}
