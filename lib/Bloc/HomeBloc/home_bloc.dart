import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youbloom_task/models/home_data_model.dart';
import 'package:youbloom_task/repos/home_repo.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<SearchEvent>(searchEvent);
  }

  List<HomeDataModel> _allData = [];

  FutureOr<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(PostFetchingLoadingState());
    _allData = await HomeRepo.fetchHome();
    emit(PostFetchingSuccessfulState(data: _allData));
  }

  FutureOr<void> searchEvent(SearchEvent event, Emitter<HomeState> emit) {
    final query = event.data.toLowerCase();
    final results = _allData
        .where((item) => item.name!.toLowerCase().contains(query))
        .toList();
    emit(SearchSuccessfullState(results: results));
  }
}
