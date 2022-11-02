import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv_season_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_tv_season_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeasonDetailProvider extends ChangeNotifier {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailProvider({
    required this.getTvSeasonDetail,
  });

  late TvSeasonDetail _tvSeasonDetail;
  TvSeasonDetail get tvSeasonDetail => _tvSeasonDetail;

  ResultState _tvSeasonDetailState = ResultState.empty;
  ResultState get tvSeasonDetailState => _tvSeasonDetailState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonDetail(int id, int seasonNumber) async {
    _tvSeasonDetailState = ResultState.loading;
    notifyListeners();
    final detailResult = await getTvSeasonDetail.execute(id, seasonNumber);
    detailResult.fold(
      (failure) {
        _tvSeasonDetailState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeasonDetail) {
        _tvSeasonDetail = tvSeasonDetail;
        _tvSeasonDetailState = ResultState.loaded;
        notifyListeners();
      },
    );
  }
}
