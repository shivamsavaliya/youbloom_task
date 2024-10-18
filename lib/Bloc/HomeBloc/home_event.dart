part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialFetchEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final String data;

  SearchEvent({required this.data});
}
