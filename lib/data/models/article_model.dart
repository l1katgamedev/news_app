class NewsModel {
  String? status;
  int? totalResults;
  List<ArticleModel> articles;

  NewsModel({this.status, this.totalResults, required this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json['status'],
        totalResults: json['totalResults'],
        articles: List<ArticleModel>.from(json['articles'].map((x) => ArticleModel.fromJson(x))),
      );
}

class ArticleModel {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  ArticleModel.fromJson(Map<String, dynamic> json) {
    source = (json['source'] != null ? Source.fromJson(json['source']) : null)!;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'] ?? 'https://www.google.com/search?q=question+&tbm=isch&ved=2ahUKEwjUgMeb2K7-AhVwhP0HHVe3AqEQ2-cCegQIABAA&oq=question+&gs_lcp=CgNpbWcQAzIHCAAQigUQQzIFCAAQgAQyBwgAEIoFEEMyBQgAEIAEMgUIABCABDIHCAAQigUQQzIFCAAQgAQyBwgAEIoFEEMyBwgAEIoFEEMyBQgAEIAEOgQIIxAnOgYIABAIEB46BwgAEBgQgAQ6BwgjEOoCECdQrwZYvpYCYNWaAmgUcAB4AIABhwGIAZAMkgEEMC4xMpgBAKABAaoBC2d3cy13aXotaW1nsAEKwAEB&sclient=img&ei=ixA8ZJSPE_CI9u8P1-6KiAo&bih=854&biw=1512#imgrc=Gi93QW_IaYtqLM';
    publishedAt = json['publishedAt'];
    content = json['content'];
  }
}

class Source {
  String? id;
  String? name;

  Source({required this.id, required this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
