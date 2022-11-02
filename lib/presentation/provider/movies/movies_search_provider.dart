import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/search_movies.dart';
import 'package:flutter/foundation.dart';

class MoviesSearchProvider extends ChangeNotifier {
  final SearchMovies searchMovies;

  MoviesSearchProvider({required this.searchMovies});

  ResultState _state = ResultState.empty;
  ResultState get state => _state;

  List<Movies> _searchResultMovies = [];
  List<Movies> get searchResultMovies => _searchResultMovies;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = ResultState.loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = ResultState.error;
        notifyListeners();
      },
      (data) {
        _searchResultMovies = data;
        _state = ResultState.loaded;
        notifyListeners();
      },
    );
  }
}
