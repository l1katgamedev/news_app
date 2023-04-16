part of 'news_bloc.dart';

abstract class NewsState {}

class InitialNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class LoadingPaginationNewsState extends NewsState {}

class LoadedNewsState extends NewsState {
  List<ArticleModel> articleModel;

  LoadedNewsState(this.articleModel);
}

class ErrorNewsState extends NewsState {
  final String? message;

  ErrorNewsState(this.message);
}
