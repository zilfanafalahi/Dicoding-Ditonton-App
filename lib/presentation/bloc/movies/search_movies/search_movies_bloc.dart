import 'package:dicoding_ditonton_app/domain/usecases/movies/search_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:equatable/equatable.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final SearchMovies searchMovies;

  SearchMoviesBloc({
    required this.searchMovies,
  }) : super(SearchMoviesInitial()) {
    on<SearchMoviesStarted>(_searchMoviesStarted);
  }

  Future<void> _searchMoviesStarted(
    SearchMoviesStarted event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(SearchMoviesLoading());

    final result = await searchMovies.execute(event.query);

    result.fold(
      (failure) {
        emit(SearchMoviesError(failure.message));
      },
      (data) {
        emit(SearchMoviesLoaded(data));
      },
    );
  }
}
