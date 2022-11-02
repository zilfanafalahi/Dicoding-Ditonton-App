import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvDetailProvider extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatusTv getWatchListStatusTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailProvider({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatusTv,
    required this.saveWatchlistTv,
    required this.removeWatchlistTv,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  ResultState _tvState = ResultState.empty;
  ResultState get tvState => _tvState;

  List<Tv> _tvRecommendations = [];
  List<Tv> get tvRecommendations => _tvRecommendations;

  ResultState _tvRecommendationState = ResultState.empty;
  ResultState get tvRecommendationState => _tvRecommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = ResultState.loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tv) {
        _tvRecommendationState = ResultState.loading;
        _tv = tv;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _tvRecommendationState = ResultState.error;
            _message = failure.message;
          },
          (tvData) {
            _tvRecommendationState = ResultState.loaded;
            _tvRecommendations = tvData;
          },
        );
        _tvState = ResultState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlistTv(TvDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> removeFromWatchlistTv(TvDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusTv(tv.id);
  }

  Future<void> loadWatchlistStatusTv(int id) async {
    final result = await getWatchListStatusTv.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
