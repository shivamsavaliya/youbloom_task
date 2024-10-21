import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youbloom_task/Repos/home_repo.dart';
import '../../Models/home_data_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialFetchEvent>(homeInitialFetchEvent);
    on<SearchEvent>(searchEvent);
    on<NameClickEvent>(nameClickEvent);
  }

  List<HomeDataModel> _allData = [];

  FutureOr<void> homeInitialFetchEvent(
      HomeInitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(PostFetchingLoadingState());
    _allData = await HomeRepo.fetchHome();
    emit(PostFetchingSuccessfulState(data: _allData));
  }

  FutureOr<void> searchEvent(SearchEvent event, Emitter<HomeState> emit) {
    final query = event.data.toLowerCase(); //aaa
    final results = _allData
        .where((item) => item.name.toString().toLowerCase().contains(query))
        .toList();
    emit(SearchSuccessfullState(results: results));
  }

  FutureOr<void> nameClickEvent(NameClickEvent event, Emitter<HomeState> emit) {
    emit(GetDetailsState(data: event.data));
  }
}
