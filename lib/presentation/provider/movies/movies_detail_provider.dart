import 'package:dicoding_ditonton_app/common/result_state.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_detail.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/get_watchlist_status_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/remove_watchlist_movie.dart';
import 'package:dicoding_ditonton_app/domain/usecases/movies/save_watchlist_movie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MoviesDetailProvider extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatusMovie getWatchListStatusMovie;
  final SaveWatchlistMovie saveWatchlistMovie;
  final RemoveWatchlistMovie removeWatchlistMovie;

  MoviesDetailProvider({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatusMovie,
    required this.saveWatchlistMovie,
    required this.removeWatchlistMovie,
  });

  late MoviesDetail _movie;
  MoviesDetail get movie => _movie;

  ResultState _movieState = ResultState.empty;
  ResultState get movieState => _movieState;

  List<Movies> _movieRecommendations = [];
  List<Movies> get movieRecommendations => _movieRecommendations;

  ResultState _movieRecommendationState = ResultState.empty;
  ResultState get movieRecommendationState => _movieRecommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = ResultState.loading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = ResultState.error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _movieRecommendationState = ResultState.loading;
        _movie = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _movieRecommendationState = ResultState.error;
            _message = failure.message;
          },
          (movies) {
            _movieRecommendationState = ResultState.loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = ResultState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlistMovie(MoviesDetail movie) async {
    final result = await saveWatchlistMovie.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusMovie(movie.id);
  }

  Future<void> removeFromWatchlistMovie(MoviesDetail movie) async {
    final result = await removeWatchlistMovie.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatusMovie(movie.id);
  }

  Future<void> loadWatchlistStatusMovie(int id) async {
    final result = await getWatchListStatusMovie.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
