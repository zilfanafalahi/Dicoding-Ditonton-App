import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_popular_movies.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:flutter/material.dart';

class MoviesListProvider extends ChangeNotifier {
  var _nowPlayingMovies = <Movies>[];
  List<Movies> get nowPlayingMovies => _nowPlayingMovies;

  ResultState _nowPlayingState = ResultState.empty;
  ResultState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movies>[];
  List<Movies> get popularMovies => _popularMovies;

  ResultState _popularMoviesState = ResultState.empty;
  ResultState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movies>[];
  List<Movies> get topRatedMovies => _topRatedMovies;

  ResultState _topRatedMoviesState = ResultState.empty;
  ResultState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  MoviesListProvider({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  });

  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = ResultState.loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = ResultState.loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = ResultState.loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = ResultState.loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = ResultState.loading;
    notifyListeners();

    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = ResultState.loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
