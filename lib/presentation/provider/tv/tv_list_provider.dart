import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_on_the_air_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_popular_tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TvListProvider extends ChangeNotifier {
  var _onTheAirTv = <Tv>[];
  List<Tv> get onTheAirTv => _onTheAirTv;

  ResultState _onTheAirState = ResultState.empty;
  ResultState get onTheAirState => _onTheAirState;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  ResultState _popularTvState = ResultState.empty;
  ResultState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  ResultState _topRatedTvState = ResultState.empty;
  ResultState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvListProvider({
    required this.getOnTheAirTv,
    required this.getPopularTv,
    required this.getTopRatedTv,
  });

  final GetOnTheAirTv getOnTheAirTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchOnTheAirTv() async {
    _onTheAirState = ResultState.loading;
    notifyListeners();

    final result = await getOnTheAirTv.execute();
    result.fold(
      (failure) {
        _onTheAirState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _onTheAirState = ResultState.loaded;
        _onTheAirTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTv() async {
    _popularTvState = ResultState.loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _popularTvState = ResultState.loaded;
        _popularTv = tvData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = ResultState.loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _topRatedTvState = ResultState.loaded;
        _topRatedTv = tvData;
        notifyListeners();
      },
    );
  }
}
