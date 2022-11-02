import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/tv/tv.dart';
import 'package:dicoding_ditonton_app/domain/usecases/tv/search_tv.dart';
import 'package:flutter/foundation.dart';

class TvSearchProvider extends ChangeNotifier {
  final SearchTv searchTv;

  TvSearchProvider({required this.searchTv});

  ResultState _state = ResultState.empty;
  ResultState get state => _state;

  List<Tv> _searchResultTv = [];
  List<Tv> get searchResultTv => _searchResultTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSearch(String query) async {
    _state = ResultState.loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = ResultState.error;
        notifyListeners();
      },
      (data) {
        _searchResultTv = data;
        _state = ResultState.loaded;
        notifyListeners();
      },
    );
  }
}
