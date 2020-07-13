import 'package:flutter/material.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:news_app/notifiers/dark_theme_provider.dart';
import 'package:news_app/screens/news_article_detail_screen.dart';
import 'package:news_app/utils/styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: HomePage(),
            routes: {
              NewsArticleDetailScreen.routeName: (ctx) =>
                  NewsArticleDetailScreen(),
            },
          );
        },
      ),
    );
  }
}
