import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_tv.dart';
import 'package:flutter/foundation.dart';

class WatchlistTvProvider extends ChangeNotifier {
  var _watchlistTv = <Tv>[];
  List<Tv> get watchlistTv => _watchlistTv;

  var _watchlistState = ResultState.empty;
  ResultState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistTvProvider({required this.getWatchlistTv});

  final GetWatchlistTv getWatchlistTv;

  Future<void> fetchWatchlistTv() async {
    _watchlistState = ResultState.loading;
    notifyListeners();

    final result = await getWatchlistTv.execute();
    result.fold(
      (failure) {
        _watchlistState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _watchlistState = ResultState.loaded;
        _watchlistTv = tvData;
        notifyListeners();
      },
    );
  }
}
