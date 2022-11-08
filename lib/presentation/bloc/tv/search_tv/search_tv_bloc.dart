import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/search_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv searchTv;

  SearchTvBloc({
    required this.searchTv,
  }) : super(SearchTvInitial()) {
    on<SearchTvStarted>(_searchTvStarted);
  }

  Future<void> _searchTvStarted(
    SearchTvStarted event,
    Emitter<SearchTvState> emit,
  ) async {
    emit(SearchTvLoading());

    final result = await searchTv.execute(event.query);

    result.fold(
      (failure) {
        emit(SearchTvError(failure.message));
      },
      (data) {
        emit(SearchTvLoaded(data));
      },
    );
  }
}
