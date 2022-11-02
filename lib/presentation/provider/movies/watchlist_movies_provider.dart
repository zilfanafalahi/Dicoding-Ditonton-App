import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistMoviesProvider extends ChangeNotifier {
  var _watchlistMovies = <Movies>[];
  List<Movies> get watchlistMovies => _watchlistMovies;

  var _watchlistState = ResultState.empty;
  ResultState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistMoviesProvider({required this.getWatchlistMovies});

  final GetWatchlistMovies getWatchlistMovies;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = ResultState.loading;
    notifyListeners();

    final result = await getWatchlistMovies.execute();
    result.fold(
      (failure) {
        _watchlistState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = ResultState.loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
