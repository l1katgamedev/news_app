part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadNewsEvent extends NewsEvent {
  final String? category;
  final int? page;

  LoadNewsEvent({this.category, this.page});
}



