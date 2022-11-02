import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvProvider extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvProvider({required this.getTopRatedTv});

  ResultState _state = ResultState.empty;
  ResultState get state => _state;

  List<Tv> _tv = [];
  List<Tv> get tv => _tv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = ResultState.loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = ResultState.error;
        notifyListeners();
      },
      (tvData) {
        _tv = tvData;
        _state = ResultState.loaded;
        notifyListeners();
      },
    );
  }
}
