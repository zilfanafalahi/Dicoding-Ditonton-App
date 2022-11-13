import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';

abstract class MoviesRepository {
  Future<Either<Failure, List<Movies>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movies>>> getPopularMovies();
  Future<Either<Failure, List<Movies>>> getTopRatedMovies();
  Future<Either<Failure, MoviesDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movies>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movies>>> searchMovies(String query);
  Future<Either<Failure, String>> saveWatchlistMovie(MoviesDetail movie);
  Future<Either<Failure, String>> removeWatchlistMovie(MoviesDetail movie);
  Future<bool> isAddedToWatchlistMovie(int id);
  Future<Either<Failure, List<Movies>>> getWatchlistMovies();
}
