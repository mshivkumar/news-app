import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:news_app/models/news_article.dart';
import 'package:news_app/utils/constants.dart';

class WebService {
  Future<List<NewsArticle>> fetchTopHeadlines() async {
    final response = await http.get(Constants.TOP_HEADLINES_URL);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJSON(article)).toList();
    } else {
      throw Exception("Failed to fetch records");
    }
  }

  Future<List<NewsArticle>> fetchHeadlinesByKeyword(String keyword) async {
    final response = await http.get(Constants.headLinesFor(keyword));
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      Iterable list = result['articles'];
      return list.map((article) => NewsArticle.fromJSON(article)).toList();
    } else {
      throw Exception("Failed to fetch records");
    }
  }
}
