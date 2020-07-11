import 'package:flutter/material.dart';
import 'package:news_app/notifiers/dark_theme_provider.dart';
import 'package:news_app/viewmodels/news_article_list_view_model.dart';
import 'package:news_app/widgets/news_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
        actions: <Widget>[
          Checkbox(
            value: themeChange.darkTheme,
            onChanged: (bool value) {
              themeChange.darkTheme = value;
            },
          ),
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => NewsArticleListViewModel(),
        child: NewsList(),
      ),
    );
  }
}
