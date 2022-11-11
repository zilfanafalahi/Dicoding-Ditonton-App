import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv/tv.dart';
import 'package:tv/domain/entities/tv/tv_detail.dart';
import 'package:tv/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/tv/save_watchlist_tv.dart';

part 'watchlist_status_tv_event.dart';
part 'watchlist_status_tv_state.dart';

class WatchlistStatusTvBloc
    extends Bloc<WatchlistStatusTvEvent, WatchlistStatusTvState> {
  final GetWatchListStatusTv getWatchListStatusTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  WatchlistStatusTvBloc({
    required this.getWatchListStatusTv,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  }) : super(WatchlistStatusTvInitial()) {
    on<SaveWatchlistStatusTvStarted>(_saveWatchlistTvsStarted);
    on<RemoveWatchlistStatusTvStarted>(_removeWatchlistTvsStarted);
    on<WatchlistStatusTvtarted>(_watchlistStatusTv);
  }

  Future<void> _watchlistStatusTv(
    WatchlistStatusTvtarted event,
    Emitter<WatchlistStatusTvState> emit,
  ) async {
    final result = await getWatchListStatusTv.execute(event.id);
    emit(IsSaveWatchlistStatusTv(result));
  }

  Future<void> _saveWatchlistTvsStarted(
    SaveWatchlistStatusTvStarted event,
    Emitter<WatchlistStatusTvState> emit,
  ) async {
    final result = await saveWatchlistTv.execute(event.detailTv);

    await result.fold(
      (failure) async {
        emit(SaveWatchlistStatusTvMessage(failure.message));
      },
      (data) async {
        emit(SaveWatchlistStatusTvMessage(data));
      },
    );

    await _watchlistStatusTv(
      WatchlistStatusTvtarted(id: event.detailTv.id),
      emit,
    );
  }

  Future<void> _removeWatchlistTvsStarted(
    RemoveWatchlistStatusTvStarted event,
    Emitter<WatchlistStatusTvState> emit,
  ) async {
    final result = await removeWatchlistTv.execute(event.detailTv);

    await result.fold(
      (failure) async {
        emit(RemoveWatchlistStatusTvMessage(failure.message));
      },
      (data) async {
        emit(RemoveWatchlistStatusTvMessage(data));
      },
    );

    await _watchlistStatusTv(
      WatchlistStatusTvtarted(id: event.detailTv.id),
      emit,
    );
  }
}
