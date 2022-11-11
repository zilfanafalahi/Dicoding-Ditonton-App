import 'package:common/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entities/movies/movies_detail.dart';
import 'package:movie/domain/repositories/movies_repository.dart';

class SaveWatchlistMovie {
  final MoviesRepository repository;

  SaveWatchlistMovie(this.repository);

  Future<Either<Failure, String>> execute(MoviesDetail movie) {
    return repository.saveWatchlistMovie(movie);
  }
}
