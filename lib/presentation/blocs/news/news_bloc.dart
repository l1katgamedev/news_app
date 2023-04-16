import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/data_sources/api_service.dart';
import 'package:news_app/data/models/article_model.dart';

part 'news_event.dart';

part 'new_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsApiService _apiService = NewsApiService();

  String? _selectedCategory;

  String? get selectedCategory => _selectedCategory;

  int _currentPage = 1;

  bool _newsAvailable = true;

  NewsBloc() : super(InitialNewsState()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(LoadingNewsState());
      try {
        List<ArticleModel> articleModel = await _apiService.fetchNewsArticle(
          category: event.category,
          page: _currentPage,
        );

        if (event.category != null) {
          _selectedCategory = event.category;
        }

        emit(LoadedNewsState(articleModel));
      } catch (e) {
        emit(ErrorNewsState('Unknown Error'));
      }
    });

    on<LoadPaginationNewsEvent>((event, emit) async {
      if (_newsAvailable) {
        emit(LoadingPaginationNewsState());

        try {
          List<ArticleModel> articleModel = await _apiService.fetchNewsArticle(
            category: event.category,
            page: _currentPage + 1,
          );

          if (articleModel.isEmpty) {
            _newsAvailable = false;
          }

          _currentPage++;

          emit(LoadedNewsState(articleModel));
        } catch (e, s) {
          emit(ErrorNewsState('Unknown Error'));
        }
      }
    });
  }
}
