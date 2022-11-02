import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton_app/common/failure.dart';
import 'package:dicoding_ditonton_app/domain/entities/movies/movies.dart';
import 'package:dicoding_ditonton_app/domain/repositories/movies_repository.dart';

class GetNowPlayingMovies {
  final MoviesRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movies>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
