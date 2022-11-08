part of 'watchlist_status_movies_bloc.dart';

abstract class WatchlistStatusMoviesState extends Equatable {
  const WatchlistStatusMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistStatusMoviesInitial extends WatchlistStatusMoviesState {}

class WatchlistStatusMoviesLoaded extends WatchlistStatusMoviesState {
  final List<Movies> result;

  const WatchlistStatusMoviesLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class SaveWatchlistStatusMoviesMessage extends WatchlistStatusMoviesState {
  final String message;

  const SaveWatchlistStatusMoviesMessage(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlistStatusMoviesMessage extends WatchlistStatusMoviesState {
  final String message;

  const RemoveWatchlistStatusMoviesMessage(this.message);

  @override
  List<Object> get props => [message];
}

class IsSaveWatchlistStatusMovies extends WatchlistStatusMoviesState {
  final bool isSave;

  const IsSaveWatchlistStatusMovies(this.isSave);

  @override
  List<Object> get props => [isSave];
}
