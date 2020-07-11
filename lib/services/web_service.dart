import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:news_app/models/news_article.dart';

class WebService {
  Future<List<NewsArticle>> fetchTopHeadlines() async {
    final String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=9678dbe3cfc044e2929c832074498868";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJSON(article)).toList();
    } else {
      throw Exception("Failed to fetch records");
    }
  }
}
