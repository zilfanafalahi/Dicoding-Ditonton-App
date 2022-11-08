import 'package:dicoding_ditonton_app/domain/entities/tv/tv_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail getTvDetail;

  DetailTvBloc({
    required this.getTvDetail,
  }) : super(DetailTvInitial()) {
    on<DetailTvStarted>(_detailTvStarted);
  }

  Future<void> _detailTvStarted(
    DetailTvStarted event,
    Emitter<DetailTvState> emit,
  ) async {
    emit(DetailTvLoading());

    final result = await getTvDetail.execute(event.id);

    result.fold(
      (failure) {
        emit(DetailTvError(failure.message));
      },
      (data) {
        emit(DetailTvLoaded(data));
      },
    );
  }
}
