part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {
  const RecommendationTvEvent();

  @override
  List<Object> get props => [];
}

class RecommendationTvStarted extends RecommendationTvEvent {
  final int id;

  const RecommendationTvStarted({required this.id});

  @override
  List<Object> get props => [id];
}
