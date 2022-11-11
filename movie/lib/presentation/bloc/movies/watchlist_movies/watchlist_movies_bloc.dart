import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movies/movies.dart';
import 'package:movie/domain/usecases/movies/get_watchlist_movies.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMoviesBloc({
    required this.getWatchlistMovies,
  }) : super(WatchlistMoviesInitial()) {
    on<WatchlistMoviesStarted>(_watchlistMoviesStarted);
  }

  Future<void> _watchlistMoviesStarted(
    WatchlistMoviesStarted event,
    Emitter<WatchlistMoviesState> emit,
  ) async {
    emit(WatchlistMoviesLoading());

    final result = await getWatchlistMovies.execute();

    result.fold(
      (failure) {
        emit(WatchlistMoviesError(failure.message));
      },
      (data) {
        emit(WatchlistMoviesLoaded(data));
      },
    );
  }
}
