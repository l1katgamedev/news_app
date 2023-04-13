part of 'home_bloc.dart';

abstract class NewsEvent {}

class LoadNewsEvent extends NewsEvent {
  final String? category;

  LoadNewsEvent({this.category});
}



