part of 'watchlist_status_tv_bloc.dart';

abstract class WatchlistStatusTvEvent extends Equatable {
  const WatchlistStatusTvEvent();

  @override
  List<Object> get props => [];
}

class WatchlistStatusTvtarted extends WatchlistStatusTvEvent {
  final int id;

  const WatchlistStatusTvtarted({required this.id});

  @override
  List<Object> get props => [id];
}

class SaveWatchlistStatusTvStarted extends WatchlistStatusTvEvent {
  final TvDetail detailTv;

  const SaveWatchlistStatusTvStarted({required this.detailTv});

  @override
  List<Object> get props => [detailTv];
}

class RemoveWatchlistStatusTvStarted extends WatchlistStatusTvEvent {
  final TvDetail detailTv;

  const RemoveWatchlistStatusTvStarted({required this.detailTv});

  @override
  List<Object> get props => [detailTv];
}
