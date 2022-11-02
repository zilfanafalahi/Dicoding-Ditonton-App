import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies_detail.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';

class SaveWatchlistMovie {
  final MoviesRepository repository;

  SaveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MoviesDetail movie) {
    return repository.saveWatchlistMovie(movie);
  }
}
