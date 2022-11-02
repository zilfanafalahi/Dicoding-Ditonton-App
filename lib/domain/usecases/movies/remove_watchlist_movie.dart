import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';

class RemoveWatchlistMovie {
  final MoviesRepository repository;

  RemoveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MoviesDetail movie) {
    return repository.removeWatchlistMovie(movie);
  }
}
