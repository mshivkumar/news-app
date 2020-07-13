import 'package:flutter/cupertino.dart';
import 'package:news_app/models/news_article.dart';
import 'package:news_app/services/web_service.dart';
import 'package:news_app/viewmodels/news_article_view_model.dart';

enum LoadingStatus { completed, searching, empty }

class NewsArticleListViewModel extends ChangeNotifier {
  LoadingStatus loadingStatus = LoadingStatus.searching;
  List<NewsArticleViewModel> articles = List<NewsArticleViewModel>();

  Future<void> search(String keyword) async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    List<NewsArticle> newsArticles =
        await WebService().fetchHeadlinesByKeyword(keyword);
    this.articles = newsArticles
        .map((article) => NewsArticleViewModel(article: article))
        .toList();
    this.loadingStatus =
        (this.articles.isEmpty) ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }

  Future<void> populateTopHeadlines() async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    List<NewsArticle> newsArticles = await WebService().fetchTopHeadlines();
    this.articles = newsArticles
        .map((article) => NewsArticleViewModel(article: article))
        .toList();
    this.loadingStatus =
        (this.articles.isEmpty) ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }
}
