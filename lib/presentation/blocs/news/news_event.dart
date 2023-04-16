part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadNewsEvent extends NewsEvent {
  final String? category;

  LoadNewsEvent({this.category});
}

class LoadPaginationNewsEvent extends NewsEvent {
  final String? category;

  LoadPaginationNewsEvent({this.category});
}
