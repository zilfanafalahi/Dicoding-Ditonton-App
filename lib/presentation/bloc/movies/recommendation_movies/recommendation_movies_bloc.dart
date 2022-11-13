import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_movies_event.dart';
part 'recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendationMoviesBloc({
    required this.getMovieRecommendations,
  }) : super(RecommendationMoviesInitial()) {
    on<RecommendationMoviesStarted>(_recommendationMoviesStarted);
  }
  Future<void> _recommendationMoviesStarted(
    RecommendationMoviesStarted event,
    Emitter<RecommendationMoviesState> emit,
  ) async {
    emit(RecommendationMoviesLoading());

    final recommendationResult =
        await getMovieRecommendations.execute(event.id);

    recommendationResult.fold(
      (failure) {
        emit(RecommendationMoviesError(failure.message));
      },
      (data) {
        emit(RecommendationMoviesLoaded(data));
      },
    );
  }
}
