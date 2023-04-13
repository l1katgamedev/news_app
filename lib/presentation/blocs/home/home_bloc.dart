import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/data/data_sources/api_service.dart';
import 'package:news_app/data/models/article_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsApiService _apiService = NewsApiService();

  String? selectedCategory;

  NewsBloc() : super(InitialNewsState()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(LoadingNewsState());
      try {
        List<ArticleModel> articleModel = await _apiService.fetchNewsArticle(
          category: event.category,
        );

        if (event.category != null) {
          selectedCategory = event.category;
        }

        emit(LoadedNewsState(articleModel));
      } catch (e) {
        emit(ErrorNewsState('Unknown Error'));
      }
    });

    // on<LoadBusinessNewsEvent>((event, emit))  async{
    //   emit(LoadingH)
    // }
  }
}
