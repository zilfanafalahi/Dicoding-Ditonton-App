import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv getWatchlistTv;

  WatchlistTvBloc({
    required this.getWatchlistTv,
  }) : super(WatchlistTvInitial()) {
    on<WatchlistTvStarted>(_watchlistTvStarted);
  }

  Future<void> _watchlistTvStarted(
    WatchlistTvStarted event,
    Emitter<WatchlistTvState> emit,
  ) async {
    emit(WatchlistTvLoading());

    final result = await getWatchlistTv.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvError(failure.message));
      },
      (data) {
        emit(WatchlistTvLoaded(data));
      },
    );
  }
}
