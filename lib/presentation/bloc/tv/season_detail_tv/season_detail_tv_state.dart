part of 'season_detail_tv_bloc.dart';

abstract class SeasonDetailTvState extends Equatable {
  const SeasonDetailTvState();

  @override
  List<Object> get props => [];
}

class SeasonDetailTvInitial extends SeasonDetailTvState {}

class SeasonDetailTvLoading extends SeasonDetailTvState {}

class SeasonDetailTvError extends SeasonDetailTvState {
  final String message;

  const SeasonDetailTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SeasonDetailTvLoaded extends SeasonDetailTvState {
  final TvSeasonDetail result;

  const SeasonDetailTvLoaded(this.result);

  @override
  List<Object> get props => [result];
}
