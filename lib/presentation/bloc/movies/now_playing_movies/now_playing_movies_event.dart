part of 'now_playing_movies_bloc.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesStarted extends NowPlayingMoviesEvent {
  @override
  List<Object> get props => [];
}
