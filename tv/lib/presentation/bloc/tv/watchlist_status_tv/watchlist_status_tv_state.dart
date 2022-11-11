part of 'watchlist_status_tv_bloc.dart';

abstract class WatchlistStatusTvState extends Equatable {
  const WatchlistStatusTvState();

  @override
  List<Object> get props => [];
}

class WatchlistStatusTvInitial extends WatchlistStatusTvState {}

class WatchlistStatusTvLoaded extends WatchlistStatusTvState {
  final List<Tv> result;

  const WatchlistStatusTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class SaveWatchlistStatusTvMessage extends WatchlistStatusTvState {
  final String message;

  const SaveWatchlistStatusTvMessage(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlistStatusTvMessage extends WatchlistStatusTvState {
  final String message;

  const RemoveWatchlistStatusTvMessage(this.message);

  @override
  List<Object> get props => [message];
}

class IsSaveWatchlistStatusTv extends WatchlistStatusTvState {
  final bool isSave;

  const IsSaveWatchlistStatusTv(this.isSave);

  @override
  List<Object> get props => [isSave];
}
