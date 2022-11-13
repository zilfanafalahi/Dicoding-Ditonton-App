import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movies_event.dart';
part 'now_playing_movies_state.dart';

class NowPlayingMoviesBloc
    extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMoviesBloc({
    required this.getNowPlayingMovies,
  }) : super(NowPlayingMoviesInitial()) {
    on<NowPlayingMoviesStarted>(_nowPlayingMoviesStarted);
  }

  Future<void> _nowPlayingMoviesStarted(
    NowPlayingMoviesStarted event,
    Emitter<NowPlayingMoviesState> emit,
  ) async {
    emit(NowPlayingMoviesLoading());

    final result = await getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMoviesError(failure.message));
      },
      (data) {
        emit(NowPlayingMoviesLoaded(data));
      },
    );
  }
}
