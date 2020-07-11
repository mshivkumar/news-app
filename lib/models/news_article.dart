class NewsArticle {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;

  NewsArticle({
    this.source,
    this.author,
    this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.publishedAt,
  });

  factory NewsArticle.fromJSON(Map<String, dynamic> json) {
    return NewsArticle(
      source: json['source'] == null ? null : Source.fromJSON(json['source']) ?? "",
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      url: json['url'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
    );
  }
}

class Source {
  final String id;
  final String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJSON(Map<String, dynamic> json) {
    return Source(
        id: json['id'] ?? "",
        name: json['name'] ?? ""
    );
  }
}
