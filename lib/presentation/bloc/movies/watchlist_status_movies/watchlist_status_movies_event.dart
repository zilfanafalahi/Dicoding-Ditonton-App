part of 'watchlist_status_movies_bloc.dart';

abstract class WatchlistStatusMoviesEvent extends Equatable {
  const WatchlistStatusMoviesEvent();

  @override
  List<Object> get props => [];
}

class WatchlistStatusMovieStarted extends WatchlistStatusMoviesEvent {
  final int id;

  const WatchlistStatusMovieStarted({required this.id});

  @override
  List<Object> get props => [id];
}

class SaveWatchlistStatusMoviesStarted extends WatchlistStatusMoviesEvent {
  final MoviesDetail detailMovies;

  const SaveWatchlistStatusMoviesStarted({required this.detailMovies});

  @override
  List<Object> get props => [detailMovies];
}

class RemoveWatchlistStatusMoviesStarted extends WatchlistStatusMoviesEvent {
  final MoviesDetail detailMovies;

  const RemoveWatchlistStatusMoviesStarted({required this.detailMovies});

  @override
  List<Object> get props => [detailMovies];
}
