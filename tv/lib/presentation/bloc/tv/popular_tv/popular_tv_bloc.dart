import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/usecases/tv/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv getPopularTv;

  PopularTvBloc({
    required this.getPopularTv,
  }) : super(PopularTvInitial()) {
    on<PopularTvStarted>(_popularTvStarted);
  }

  Future<void> _popularTvStarted(
    PopularTvStarted event,
    Emitter<PopularTvState> emit,
  ) async {
    emit(PopularTvLoading());

    final result = await getPopularTv.execute();

    result.fold(
      (failure) {
        emit(PopularTvError(failure.message));
      },
      (data) {
        emit(PopularTvLoaded(data));
      },
    );
  }
}
