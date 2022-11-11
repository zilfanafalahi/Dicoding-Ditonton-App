import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/usecases/tv/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvBloc({
    required this.getTopRatedTv,
  }) : super(TopRatedTvInitial()) {
    on<TopRatedTvStarted>(_topRatedTvStarted);
  }

  Future<void> _topRatedTvStarted(
    TopRatedTvStarted event,
    Emitter<TopRatedTvState> emit,
  ) async {
    emit(TopRatedTvLoading());

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvError(failure.message));
      },
      (data) {
        emit(TopRatedTvLoaded(data));
      },
    );
  }
}
