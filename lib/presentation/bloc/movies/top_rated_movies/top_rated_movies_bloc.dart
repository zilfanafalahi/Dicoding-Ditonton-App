import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc
    extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({
    required this.getTopRatedMovies,
  }) : super(TopRatedMoviesInitial()) {
    on<TopRatedMoviesStarted>(_topRatedMoviesStarted);
  }

  Future<void> _topRatedMoviesStarted(
    TopRatedMoviesStarted event,
    Emitter<TopRatedMoviesState> emit,
  ) async {
    emit(TopRatedMoviesLoading());

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedMoviesError(failure.message));
      },
      (data) {
        emit(TopRatedMoviesLoaded(data));
      },
    );
  }
}
