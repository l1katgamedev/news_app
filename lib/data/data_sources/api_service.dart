import 'package:dio/dio.dart';
import 'package:news_app/core/network/api_service.dart';
import 'package:news_app/data/models/article_model.dart';

class NewsApiService {
  final Dio _dio = Dio();

  Future<List<ArticleModel>> fetchNewsArticle({String? category}) async {
    Map<String, dynamic> queryParams = {
      'country': 'us',
      'apiKey': ApiService.apiKey,
      'category': category,
    };

    try {
      Response response = await _dio.get(
        '${ApiService.baseUrl}/top-headlines',
        queryParameters: queryParams,
      );
      NewsModel newsModel = NewsModel.fromJson(response.data);
      return newsModel.articles;
    } on DioError catch (e) {
      throw Exception('Exception: $e');
    }
  }

}
