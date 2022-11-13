import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_popular_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({
    required this.getPopularMovies,
  }) : super(PopularMoviesInitial()) {
    on<PopularMoviesStarted>(_popularMoviesStarted);
  }

  Future<void> _popularMoviesStarted(
    PopularMoviesStarted event,
    Emitter<PopularMoviesState> emit,
  ) async {
    emit(PopularMoviesLoading());

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMoviesError(failure.message));
      },
      (data) {
        emit(PopularMoviesLoaded(data));
      },
    );
  }
}
