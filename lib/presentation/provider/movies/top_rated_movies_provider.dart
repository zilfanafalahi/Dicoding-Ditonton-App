import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:flutter/foundation.dart';

class TopRatedMoviesProvider extends ChangeNotifier {
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesProvider({required this.getTopRatedMovies});

  ResultState _state = ResultState.empty;
  ResultState get state => _state;

  List<Movies> _movies = [];
  List<Movies> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedMovies() async {
    _state = ResultState.loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = ResultState.error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = ResultState.loaded;
        notifyListeners();
      },
    );
  }
}
