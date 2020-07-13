import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/screens/news_article_detail_screen.dart';
import 'package:news_app/viewmodels/news_article_view_model.dart';

class NewsList extends StatelessWidget {
  final List<NewsArticleViewModel> _articles;
  final Function(NewsArticleViewModel article) onSelected;

  NewsList({List<NewsArticleViewModel> articles, this.onSelected})
      : _articles = articles;

  String daysAgo(String date) {
    var parsedDate = DateTime.parse(date);
    final today = DateTime.now();
    int difference = today.difference(parsedDate).inDays;
    if (difference >= 1) {
      return "${difference} days ago";
    } else {
      return "${DateFormat('kk:mm').format(parsedDate)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
          child: GestureDetector(
            onTap: () {
              onSelected(_articles[index]);
            },
            child: Card(
              color: Theme.of(context).cardColor,
              elevation: 2,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0)),
                    child: Container(
                      height: 194,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: (_articles[index].urlToImage != null)
                          ? Image.network(
                              _articles[index].urlToImage,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/placeholder.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Container(
                    height: 130,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          _articles[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              letterSpacing: .5,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          _articles[index].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _articles[index].sourceName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    letterSpacing: .5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text("${daysAgo(_articles[index].publishedAt)}"),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      itemCount: _articles.length,
    );
  }
}
