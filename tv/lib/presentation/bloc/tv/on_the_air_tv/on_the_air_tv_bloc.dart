import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/usecases/tv/get_on_the_air_tv.dart';

part 'on_the_air_tv_event.dart';
part 'on_the_air_tv_state.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTv getOnTheAirTv;

  OnTheAirTvBloc({
    required this.getOnTheAirTv,
  }) : super(OnTheAirTvInitial()) {
    on<OnTheAirTvStarted>(_onTheAirTvStarted);
  }

  Future<void> _onTheAirTvStarted(
    OnTheAirTvStarted event,
    Emitter<OnTheAirTvState> emit,
  ) async {
    emit(OnTheAirTvLoading());

    final result = await getOnTheAirTv.execute();

    result.fold(
      (failure) {
        emit(OnTheAirTvError(failure.message));
      },
      (data) {
        emit(OnTheAirTvLoaded(data));
      },
    );
  }
}
