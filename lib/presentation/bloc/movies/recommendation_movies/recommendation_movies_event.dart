part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
  const RecommendationMoviesEvent();

  @override
  List<Object> get props => [];
}

class RecommendationMoviesStarted extends RecommendationMoviesEvent {
  final int id;

  const RecommendationMoviesStarted({required this.id});

  @override
  List<Object> get props => [id];
}
