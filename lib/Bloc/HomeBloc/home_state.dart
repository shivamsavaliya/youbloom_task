part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

abstract class PostActionState extends HomeState {}

class PostFetchingSuccessfulState extends HomeState {
  final List<HomeDataModel> data;
  PostFetchingSuccessfulState({required this.data});
}

class PostFetchingLoadingState extends HomeState {}

class PostFetchingErrorfulState extends HomeState {}

class SearchSuccessfullState extends HomeState {
  final List<HomeDataModel> results;

  SearchSuccessfullState({required this.results});
}
