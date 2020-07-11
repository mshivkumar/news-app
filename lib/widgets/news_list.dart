import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/viewmodels/news_article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:news_app/utils/styles.dart';
import 'package:intl/intl.dart';

class NewsList extends StatelessWidget {
//  NewsArticleListViewModel _newsArticleListViewModel =
//      NewsArticleListViewModel();
//
//  NewsList() {
//    _newsArticleListViewModel.populateTopHeadlines();
//  }

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
    final vm = Provider.of<NewsArticleListViewModel>(context);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
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
                    child: Image.network(
                      vm.articles[index].urlToImage,
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
                        vm.articles[index].title,
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
                        vm.articles[index].description,
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
                            vm.articles[index].sourceName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Text("${daysAgo(vm.articles[index].publishedAt)}"),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: vm.articles.length,
    );
  }
}
