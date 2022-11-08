import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations getTvRecommendations;

  RecommendationTvBloc({
    required this.getTvRecommendations,
  }) : super(RecommendationTvInitial()) {
    on<RecommendationTvStarted>(_recommendationTvStarted);
  }
  Future<void> _recommendationTvStarted(
    RecommendationTvStarted event,
    Emitter<RecommendationTvState> emit,
  ) async {
    emit(RecommendationTvLoading());

    final recommendationResult = await getTvRecommendations.execute(event.id);

    recommendationResult.fold(
      (failure) {
        emit(RecommendationTvError(failure.message));
      },
      (data) {
        emit(RecommendationTvLoaded(data));
      },
    );
  }
}
