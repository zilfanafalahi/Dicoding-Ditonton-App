import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv_season_detail.dart';
import 'package:tv/domain/usecases/tv/get_tv_season_detail.dart';

part 'season_detail_tv_event.dart';
part 'season_detail_tv_state.dart';

class SeasonDetailTvBloc
    extends Bloc<SeasonDetailTvEvent, SeasonDetailTvState> {
  final GetTvSeasonDetail getTvSeasonDetail;

  SeasonDetailTvBloc({
    required this.getTvSeasonDetail,
  }) : super(SeasonDetailTvInitial()) {
    on<SeasonDetailTvStarted>(_seasonDetailTvStarted);
  }

  Future<void> _seasonDetailTvStarted(
    SeasonDetailTvStarted event,
    Emitter<SeasonDetailTvState> emit,
  ) async {
    emit(SeasonDetailTvLoading());

    final result =
        await getTvSeasonDetail.execute(event.id, event.seasonNumber);

    result.fold(
      (failure) {
        emit(SeasonDetailTvError(failure.message));
      },
      (data) {
        emit(SeasonDetailTvLoaded(data));
      },
    );
  }
}
