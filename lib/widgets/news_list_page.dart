import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/news_article_detail_screen.dart';
import 'package:news_app/viewmodels/news_article_list_view_model.dart';
import 'package:news_app/viewmodels/news_article_view_model.dart';
import 'package:news_app/widgets/news_list.dart';
import 'package:provider/provider.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  TextEditingController _searchController = TextEditingController();

  Widget _buildList(BuildContext context, NewsArticleListViewModel vm) {
    switch (vm.loadingStatus) {
      case LoadingStatus.searching:
        return Align(
          child: CircularProgressIndicator(),
        );
        break;
      case LoadingStatus.empty:
        return Align(
          child: Text("No Results Found"),
        );
        break;
      case LoadingStatus.completed:
        return NewsList(
          articles: vm.articles,
          onSelected: (article) {
            _showNewsArticleDetail(context, article);
          },
        );
        break;
      default:
        return Align(
          child: Text("Something went wrong"),
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    Provider.of<NewsArticleListViewModel>(context, listen: false)
        .populateTopHeadlines();
  }

  void _showNewsArticleDetail(
      BuildContext context, NewsArticleViewModel article) {
    Navigator.of(context).pushNamed(
      NewsArticleDetailScreen.routeName,
      arguments: {
        'article': article,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<NewsArticleListViewModel>(context);
    return Column(
      children: <Widget>[
        TextField(
          controller: _searchController,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              vm.search(value);
            }
          },
          decoration: InputDecoration(
            hintText: "Search",
            prefixIcon: Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
        ),
        Expanded(
          child: _buildList(context, vm),
        ),
      ],
    );
  }
}
