import 'package:flutter/material.dart';
import 'package:news_app/viewmodels/news_article_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticleDetailScreen extends StatelessWidget {
  static final routeName = "/article-detail-screen";

  @override
  Widget build(BuildContext context) {
    NewsArticleViewModel _article;

    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    _article = routeArgs["article"];
    return Scaffold(
      appBar: AppBar(
        title: Text(_article.title),
      ),
      body: WebView(
        initialUrl: _article.url,
      ),
    );
  }
}
