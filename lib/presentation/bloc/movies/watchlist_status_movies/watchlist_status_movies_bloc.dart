import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_status_movies_event.dart';
part 'watchlist_status_movies_state.dart';

class WatchlistStatusMoviesBloc
    extends Bloc<WatchlistStatusMoviesEvent, WatchlistStatusMoviesState> {
  final GetWatchListStatusMovie getWatchListStatusMovie;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistStatusMoviesBloc({
    required this.getWatchListStatusMovie,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
  }) : super(WatchlistStatusMoviesInitial()) {
    on<SaveWatchlistStatusMoviesStarted>(_saveWatchlistMoviesStarted);
    on<RemoveWatchlistStatusMoviesStarted>(_removeWatchlistMoviesStarted);
    on<WatchlistStatusMovieStarted>(_watchlistStatusMovies);
  }

  Future<void> _watchlistStatusMovies(
    WatchlistStatusMovieStarted event,
    Emitter<WatchlistStatusMoviesState> emit,
  ) async {
    final result = await getWatchListStatusMovie.execute(event.id);
    emit(IsSaveWatchlistStatusMovies(result));
  }

  Future<void> _saveWatchlistMoviesStarted(
    SaveWatchlistStatusMoviesStarted event,
    Emitter<WatchlistStatusMoviesState> emit,
  ) async {
    final result = await saveWatchlistMovie.execute(event.detailMovies);

    await result.fold(
      (failure) async {
        emit(SaveWatchlistStatusMoviesMessage(failure.message));
      },
      (data) async {
        emit(SaveWatchlistStatusMoviesMessage(data));
      },
    );

    await _watchlistStatusMovies(
      WatchlistStatusMovieStarted(id: event.detailMovies.id),
      emit,
    );
  }

  Future<void> _removeWatchlistMoviesStarted(
    RemoveWatchlistStatusMoviesStarted event,
    Emitter<WatchlistStatusMoviesState> emit,
  ) async {
    final result = await removeWatchlistMovie.execute(event.detailMovies);

    await result.fold(
      (failure) async {
        emit(RemoveWatchlistStatusMoviesMessage(failure.message));
      },
      (data) async {
        emit(RemoveWatchlistStatusMoviesMessage(data));
      },
    );

    await _watchlistStatusMovies(
      WatchlistStatusMovieStarted(id: event.detailMovies.id),
      emit,
    );
  }
}
